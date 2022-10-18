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
    
    let imageDownloadService = ImageDownloadService()
    
    func configure(with parrot: Parrot) {
        container.layer.cornerRadius = 20
        container.makeShadow()
        parrotImageView.layer.borderColor = UIColor.black.cgColor
        
        parrotImageView.layer.borderWidth = 2.5
        parrotImageView.layer.cornerRadius = 70
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        breedLabel.text = parrot.breed
        interestingFact.text = parrot.interestingFact
        
        imageDownloadService.getData(from: parrot.images[0]) { [weak self] result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self?.parrotImageView.image = image
                }
            case .failure(_):
                break
            }
        }
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
