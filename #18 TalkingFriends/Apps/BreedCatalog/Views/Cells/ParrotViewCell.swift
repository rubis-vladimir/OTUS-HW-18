//
//  ParrotViewCell.swift
//  #18 TalkingFriends
//
//  Created by Владимир Рубис on 16.10.2022.
//

import UIKit

class ParrotViewCell: UITableViewCell {

    @IBOutlet weak var parrotImageView: UIImageView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet var interestingFact: UILabel!
    
    func configure(with parrot: Parrot) {
        container.layer.cornerRadius = 20
        container.makeShadow()
        parrotImageView.layer.borderColor = UIColor.black.cgColor
        
        parrotImageView.layer.borderWidth = 2.5
        parrotImageView.layer.cornerRadius = 70
        self.backgroundColor = .clear
    }
    
    
}


extension UIView {
    func makeShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 3
    }
}
