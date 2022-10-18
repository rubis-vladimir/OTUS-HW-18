//
//  BreedCatalogViewController.swift
//  #18 TalkingFriends
//
//  Created by Владимир Рубис on 16.10.2022.
//

import UIKit

protocol ParrotCatalogPresenterDelegate: AnyObject {
    func updateUI()
    
    func showError(_ error: Error)
}

final class ParrotCatalogViewController: UIViewController {
    
    // MARK: - Properties
    private let presenter: ParrotCatalogPresentation
    private var catalogTableView = UITableView()
    
    private var parrots: [Parrot] = []
    
    init(presenter: ParrotCatalogPresentation) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мои говорящие друзья"
        
        setupUI()
        presenter.getParrots()
    }
    
    private func setupUI() {
        
        view.addSubview(catalogTableView)
        setupTableView()
        
        
        
        if let font = UIFont(name: "MarkerFelt-Thin", size: 28) {
            
                let navigationBarAppearance = UINavigationBarAppearance()
                navigationBarAppearance.configureWithOpaqueBackground()
                navigationBarAppearance.backgroundColor = #colorLiteral(red: 1, green: 0.8431372549, blue: 0.6509803922, alpha: 1)
                navigationBarAppearance.titleTextAttributes = [
                    .font : font
                ]
                navigationController?.navigationBar.standardAppearance = navigationBarAppearance
            }
    }
    
    private func setupTableView() {
        //        catalogTableView = UITableView(frame: view.bounds, style: .plain)
        catalogTableView.translatesAutoresizingMaskIntoConstraints = false
        catalogTableView.dataSource = self
        catalogTableView.delegate = self
        catalogTableView.register(UINib(nibName: String(describing: ParrotViewCell.self),
                                        bundle: nil),
                                  forCellReuseIdentifier: String(describing: ParrotViewCell.self))
        catalogTableView.backgroundColor = #colorLiteral(red: 1, green: 0.8431372549, blue: 0.6509803922, alpha: 1)
        catalogTableView.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            catalogTableView.topAnchor.constraint(equalTo: view.topAnchor),
            catalogTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            catalogTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            catalogTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource
extension ParrotCatalogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        parrots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ParrotViewCell.self)) as! ParrotViewCell
        let parrot = parrots[indexPath.row]
        cell.configure(with: parrot)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ParrotCatalogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let parrot = parrots[indexPath.row]
        presenter.tapDetail(parrot: parrot)
        
        //        let vc = UIViewController()
        //        vc.view.backgroundColor = .orange
        //        self.present(vc, animated: true)
    }
}

// MARK: - ParrotCatalogPresenterDelegate
extension ParrotCatalogViewController: ParrotCatalogPresenterDelegate {
    func updateUI() {
        guard let parrots = presenter.parrots else { return }
        self.parrots = parrots
        catalogTableView.reloadData()
    }
    
    func showError(_ error: Error) {
        
    }
}
