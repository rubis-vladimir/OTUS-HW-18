//
//  DetailInfoRouter.swift
//  #18 TalkingFriends
//
//  Created by Владимир Рубис on 16.10.2022.
//

import UIKit

protocol DetailInfoRouting: Routing {
    func popToRoot()
    func routeToYoutube(urlString: String)
}


final class DetailInfoRouter {
    
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension DetailInfoRouter: DetailInfoRouting {
    func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func routeToYoutube(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url, options: [ : ] , completionHandler: nil)
    }
}
