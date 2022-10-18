//
//  UIViewController + CustomBarButton.swift
//  #18 TalkingFriends
//
//  Created by Владимир Рубис on 18.10.2022.
//

import UIKit

extension UIViewController {
    
    func createCustomBarButton(imageName: String,
                               title: String,
                               font: UIFont,
                               selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(
            UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate),
            for: .normal
        )
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = font
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }
}
