//
//  DetailInfoRouter.swift
//  #18 TalkingFriends
//
//  Created by Владимир Рубис on 16.10.2022.
//

import UIKit

/// Протокол маршрутизации модуля DetailInfo
protocol DetailInfoRouting: Routing {
    /// Возврат на стартовый экран
    func popToRoot()
    /// Переход по ссылке на Youtube
    func routeToYoutube(urlString: String)
}

/// Слой маршрутизации модуля DetailInfo
final class DetailInfoRouter {
    
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - DetailInfoRouting
extension DetailInfoRouter: DetailInfoRouting {
    func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func routeToYoutube(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url, options: [ : ] , completionHandler: nil)
    }
}
