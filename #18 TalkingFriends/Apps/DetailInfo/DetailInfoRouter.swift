//
//  DetailInfoRouter.swift
//  #18 TalkingFriends
//
//  Created by Владимир Рубис on 16.10.2022.
//

import Foundation
import UIKit

protocol DetailInfoRouting: Routing {
    func route()
}


final class DetailInfoRouter {
    
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension DetailInfoRouter: DetailInfoRouting {
    func route() {
        
    }
}
