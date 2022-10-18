//
//  ParrotViewCell.swift
//  #18 TalkingFriends
//
//  Created by Владимир Рубис on 16.10.2022.
//

import UIKit

class ParrotViewCell: UITableViewCell {
    
    @IBOutlet weak var parrotImageView: UIImageView!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet var interestingFactLabel: UILabel!
    @IBOutlet weak var container: UIView!
    
    private struct Constants {
        static var cornerRadius: CGFloat = 20
        static var borderWidth: CGFloat = 2.5
        static var borderColor = UIColor.black.cgColor
    }
    
    weak var delegate: ParrotCatalogImageDownloadable?
    
    func configure(with parrot: Parrot) {
        backgroundColor = .clear
        selectionStyle = .none
        
        parrotImageView.layer.borderColor = Constants.borderColor
        parrotImageView.layer.borderWidth = Constants.borderWidth
        
        breedLabel.text = parrot.breed
        interestingFactLabel.text = parrot.interestingFact
        
        container.layer.cornerRadius = Constants.cornerRadius
        container.makeShadow()
        
        guard let parrotImageUrl = parrot.images.first else { return }
        
        delegate?.getParrotImage(url: parrotImageUrl) { [weak self] result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self?.parrotImageView.image = image
                }
            case .failure(_):
                /// Обработка ошибки
                print("Изображение по url: \(parrotImageUrl) не загружено")
            }
        }
    }
}
