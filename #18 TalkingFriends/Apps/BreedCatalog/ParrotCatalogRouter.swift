//
//  ParrotCatalogRouter.swift
//  #18 TalkingFriends
//
//  Created by Владимир Рубис on 16.10.2022.
//

import UIKit

/// Протокол маршрутизации модуля ParrotCatalog
protocol ParrotCatalogRouting: Routing {
    /// Переход к экрану детальной информации
    func showDetail(parrot: Parrot?)
}

/// Слой маршрутизации модуля ParrotCatalog
final class ParrotCatalogRouter {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - ParrotCatalogRouting
extension ParrotCatalogRouter: ParrotCatalogRouting {
    
    func showDetail(parrot: Parrot?) {
        guard let nc = navigationController,
        let parrot = parrot else { return }
        let vc = DetailInfoAssembly(navigationController: nc, parrot: parrot).assembly()
        nc.pushViewController(vc, animated: true)
    }
}
