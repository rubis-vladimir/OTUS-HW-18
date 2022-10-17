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
    
    private var catalogTableView = UITableView()
    
    private var parrots: [Parrot] = []
    
    private let presenter: ParrotCatalogPresentation
    
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
        if let font = UIFont(name: "MarkerFelt-Thin", size: 28) {
            navigationController?.navigationBar.titleTextAttributes = [.font: font]
        }
        setupTableView()
    }
    
    private func setupTableView() {
        catalogTableView = UITableView(frame: view.bounds, style: .plain)
        catalogTableView.dataSource = self
        catalogTableView.delegate = self
        catalogTableView.register(UINib(nibName: String(describing: ParrotViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ParrotViewCell.self))
        catalogTableView.backgroundColor = #colorLiteral(red: 1, green: 0.8442435808, blue: 0.6522630586, alpha: 1)
        catalogTableView.separatorStyle = .none
        view.backgroundColor = #colorLiteral(red: 1, green: 0.8442435808, blue: 0.6522630586, alpha: 1)
        view.addSubview(catalogTableView)
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
}

// MARK: - ParrotCatalogPresenterDelegate
extension ParrotCatalogViewController: ParrotCatalogPresenterDelegate {
    func updateUI() {
        
    }
    
    func showError(_ error: Error) {
        
    }
}
