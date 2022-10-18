//
//  UIView + Shadow.swift
//  #18 TalkingFriends
//
//  Created by Владимир Рубис on 18.10.2022.
//

import UIKit

extension UIView {
    func makeShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 3
    }
}
