//
//  DetailInfoViewController.swift
//  #18 TalkingFriends
//
//  Created by Владимир Рубис on 16.10.2022.
//

import UIKit

protocol DetailInfoPresenterDelegate: AnyObject {
    
}

final class DetailInfoViewController: UIViewController {

    
    @IBOutlet weak var parrotImageView: UIImageView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var photoView: UIView!
    
    @IBOutlet var images: [UIImageView]!
    
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var contentFeaturesLabel: UILabel!
    
    @IBOutlet weak var sizeLabel: UILabel!
    
    @IBOutlet weak var habitatLabel: UILabel!
    
    @IBOutlet weak var interestingFactLabel: UILabel!
    
    let imageDownloadService = ImageDownloadService()
    private let presenter: DetailInfoPresenter
    
    init(presenter: DetailInfoPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parrotImageView.layer.cornerRadius = 75
        parrotImageView.layer.borderWidth = 2.5
        parrotImageView.layer.borderColor = UIColor.black.cgColor
        container.layer.cornerRadius = 20
        container.makeShadow()
        
        photoView.makeShadow()
        photoView.layer.cornerRadius = 20
        stackView.layer.cornerRadius = 20
        stackView.clipsToBounds = true
        
        navigationController?.navigationBar.tintColor = .black
//        navigationController?.navigationBar.titleTextAttributes =
        
        navigationItem.leftBarButtonItem = createCustomBarButton(
            imageName: "chevron.backward",
            selector: #selector(cancelLeftButtonTapped)
        )
        
        guard let parrot = presenter.parrot else { return }
        
        let imageUrls = parrot.images
        breedLabel.text = parrot.breed
        habitatLabel.text = "Место обитания: \(parrot.habitat)"
        sizeLabel.text = "Размер: до \(parrot.size) см"
        contentFeaturesLabel.text = "Особенности содержания: \(parrot.contentFeatures)"
        interestingFactLabel.text = "Интересный факт: \(parrot.interestingFact)"
        
        images.enumerated().forEach { (index, imageView) in
            
            let imageUrl = imageUrls[index]
            
            imageDownloadService.getData(from: imageUrl) { result in
                switch result {
                case .success(let data):
                    guard let image = UIImage(data: data) else { return }
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                case .failure(_):
                    break
                }
            }
        }
    }
    @objc private func cancelLeftButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func createCustomBarButton(imageName: String, selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(
            UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate),
            for: .normal
        )
        button.setTitle(" Мои говорящие друзья", for: .normal)
        button.titleLabel?.font = UIFont(name: "MarkerFelt-Thin", size: 18)
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }
}

extension DetailInfoViewController: DetailInfoPresenterDelegate {
    
}
