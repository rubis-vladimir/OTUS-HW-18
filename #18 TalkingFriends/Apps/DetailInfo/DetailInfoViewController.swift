//
//  DetailInfoViewController.swift
//  #18 TalkingFriends
//
//  Created by Владимир Рубис on 16.10.2022.
//

import UIKit

/// Контроллер представления детальной информации попугая
final class DetailInfoViewController: UIViewController {
    
    // MARK: - Properties & IBOutlet
    @IBOutlet weak var parrotImageView: UIImageView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var photoView: UIView!
    @IBOutlet var imageViews: [UIImageView]!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var contentFeaturesLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var habitatLabel: UILabel!
    @IBOutlet weak var interestingFactLabel: UILabel!
    
    private let presenter: DetailInfoPresenter
    
    private let singleTapGestureRecognizer = UITapGestureRecognizer()
    private let doubleTapGestureRecognizer = UITapGestureRecognizer()
    
    private struct Constants {
        static var imageCornerRadius: CGFloat = 75
        static var cornerRadius: CGFloat = 20
        static var borderColor = UIColor.black.cgColor
        static var borderWidth = 2.5
    }
    
    // MARK: - Init
    init(presenter: DetailInfoPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavBar()
        setupGestureRecognizers()
    }
    
    // MARK: - Private func
    private func setupUI() {
        parrotImageView.layer.cornerRadius = Constants.imageCornerRadius
        parrotImageView.layer.borderWidth = Constants.borderWidth
        parrotImageView.layer.borderColor = Constants.borderColor
        
        container.layer.cornerRadius = Constants.cornerRadius
        container.makeShadow()
        
        photoView.layer.cornerRadius = Constants.cornerRadius
        photoView.makeShadow()
        
        stackView.layer.cornerRadius = Constants.cornerRadius
        stackView.clipsToBounds = true
        
        guard let parrot = presenter.parrot else { return }
        
        breedLabel.text = parrot.breed
        habitatLabel.text = "Место обитания: \(parrot.habitat)"
        sizeLabel.text = "Размер: до \(parrot.size) см"
        contentFeaturesLabel.text = "Особенности содержания: \(parrot.contentFeatures)"
        interestingFactLabel.text = "Интересный факт: \(parrot.interestingFact)"
        
        downloadImages(with: parrot)
    }
    
    /// Загружает картинки и устанавливает их
    private func downloadImages(with parrot: Parrot) {
        let allImageViews = [parrotImageView] + imageViews
        
        allImageViews.enumerated().forEach { (index, imageView) in
            let urlString = parrot.images[index]
            presenter.getParrotImage(url: urlString) { result in
                switch result {
                    
                case .success(let data):
                    guard let image = UIImage(data: data) else { return }
                    DispatchQueue.main.async {
                        imageView?.image = image
                    }
                case .failure(_):
                    /// Обработка ошибки
                    print("Изображение по url: \(urlString) не загружено")
                }
            }
        }
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.tintColor = .black
        let font = UIFont(name: "MarkerFelt-Thin", size: 18) ?? UIFont()
        navigationItem.leftBarButtonItem = createCustomBarButton(
            imageName: "chevron.backward",
            title: " Мои говорящие друзья",
            font: font,
            selector: #selector(cancelLeftButtonTapped)
        )
    }
    
    /// Настройка отработки касаний экрана
    private func setupGestureRecognizers() {
        singleTapGestureRecognizer.addTarget(self, action: #selector(handleSingleTapGesture(_:)))
        doubleTapGestureRecognizer.addTarget(self, action: #selector(handleDoubleTapGesture(_:)))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        
        singleTapGestureRecognizer.delegate = self
        doubleTapGestureRecognizer.delegate = self
        
        parrotImageView.addGestureRecognizer(singleTapGestureRecognizer)
        parrotImageView.addGestureRecognizer(doubleTapGestureRecognizer)
    }
    
    /// Действие при двойном нажатии - переход к youtube-видео
    @objc private func handleDoubleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let parrot = presenter.parrot else { return }
        let videoUrlString = parrot.video
        presenter.openYoutube(with: videoUrlString)
    }
    
    /// Действие при одинарном нажатии - появляется изображение Youtube
    @objc private func handleSingleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        
        guard let image = UIImage(named: "youtube") else { return }
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.parrotImageView.frame.width, height: self.parrotImageView.frame.height))
        imageView.image = image
        parrotImageView.addSubview(imageView)
        
        imageView.alpha = 0.5
        
        UIView.animate(withDuration: 1.5, delay: 0.5, options: .curveEaseIn) {
            imageView.alpha = 0
        } completion: { [weak self] finished in
            self?.parrotImageView.subviews.last?.removeFromSuperview()
        }
    }
    
    @objc private func cancelLeftButtonTapped() {
        presenter.tapGoBack()
    }
}

// MARK: - UIGestureRecognizerDelegate
extension DetailInfoViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer === singleTapGestureRecognizer && otherGestureRecognizer === doubleTapGestureRecognizer
    }
}
