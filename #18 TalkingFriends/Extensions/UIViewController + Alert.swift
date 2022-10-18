//
//  UIViewController + Alert.swift
//  #18 TalkingFriends
//
//  Created by Владимир Рубис on 18.10.2022.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String,
                   message: String) {
        let alert =  UIAlertController(title: title,
                                       message: message,
                                       preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
