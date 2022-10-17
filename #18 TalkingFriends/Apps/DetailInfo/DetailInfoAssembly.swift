//
//  DetailInfoAssembly.swift
//  #18 TalkingFriends
//
//  Created by Владимир Рубис on 16.10.2022.
//

import UIKit

/// Компоновщик модуля DetailInfo
final class DetailInfoAssembly {
    
    private let navigationController: UINavigationController
    private var parrot: Parrot?
    
    init(navigationController: UINavigationController,
         parrot: Parrot) {
        self.navigationController = navigationController
        self.parrot = parrot
    }
}

extension DetailInfoAssembly: Assemblying {
    
    func assembly() -> UIViewController {
        let router = DetailInfoRouter(navigationController: navigationController)
        let presenter = DetailInfoPresenter(router: router,
                                            parrot: parrot)
        let viewController = DetailInfoViewController(presenter: presenter)
        presenter.delegate = viewController
        return viewController
    }
}
