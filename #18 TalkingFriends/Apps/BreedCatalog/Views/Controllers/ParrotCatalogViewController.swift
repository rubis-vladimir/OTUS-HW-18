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
    
    private struct Constants {
        static var font: UIFont? = UIFont(name: "MarkerFelt-Thin", size: 28)
        static var bgColor: UIColor = #colorLiteral(red: 1, green: 0.8431372549, blue: 0.6509803922, alpha: 1)
        static var title: String = "Мои говорящие друзья"
    }
    
    init(presenter: ParrotCatalogPresentation) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        presenter.getParrots()
    }
    
    private func setupUI() {
        title = Constants.title
        setupNavBar()
        setupTableView()
    }
    
    private func setupNavBar() {
        if let font = Constants.font {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.backgroundColor = Constants.bgColor
            navigationBarAppearance.titleTextAttributes = [.font : font]
            navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        }
    }
    
    private func setupTableView() {
        catalogTableView.translatesAutoresizingMaskIntoConstraints = false
        catalogTableView.dataSource = self
        catalogTableView.delegate = self
        catalogTableView.register(UINib(nibName: String(describing: ParrotViewCell.self),
                                        bundle: nil),
                                  forCellReuseIdentifier: String(describing: ParrotViewCell.self))
        catalogTableView.backgroundColor = Constants.bgColor
        catalogTableView.separatorStyle = .none
        
        view.addSubview(catalogTableView)
        
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
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int { parrots.count }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ParrotViewCell.self)) as! ParrotViewCell
        let parrot = parrots[indexPath.row]
        cell.delegate = presenter
        cell.configure(with: parrot)
        cell.parrotImageView.layer.cornerRadius = (view.bounds.width - 120) / 4
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ParrotCatalogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat { 0.5 * view.bounds.width }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let parrot = parrots[indexPath.row]
        presenter.tapDetail(parrot: parrot)
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
        guard let error = error as? DataFetcherError else { return }
        switch error {
        case .failedToLoad, .notFile:
            showAlert(title: "Внимание!", message: "Данные не были получены")
        case .failedToDecode:
            showAlert(title: "Внимание!", message: "Не удалось декодировать данные из JSON")
        case .imageFailedToLoad:
            showAlert(title: "Внимание!", message: "Одну или несколько фотографий не удалось загрузить")
        }
    }
}
