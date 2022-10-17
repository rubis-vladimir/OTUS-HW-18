//
//  ParrotCatalogAssembly.swift
//  #18 TalkingFriends
//
//  Created by Владимир Рубис on 16.10.2022.
//

import UIKit

/// Компоновщик модуля ParrotCatalog
final class ParrotCatalogAssembly {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension ParrotCatalogAssembly: Assemblying {
    
    func assembly() -> UIViewController {
        let router = ParrotCatalogRouter(navigationController: navigationController)
        let presenter = ParrotCatalogPresenter(router: router)
        let viewController = ParrotCatalogViewController(presenter: presenter)
        presenter.delegate = viewController
        return viewController
    }
}
