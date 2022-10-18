//
//  DetailInfoPresenter.swift
//  #18 TalkingFriends
//
//  Created by Владимир Рубис on 16.10.2022.
//


import UIKit

/// Протокол обработки UI-ивентов модуля DetailInfo
protocol DetailInfoPresentation: ImageDownloadable {
    /// Модель попугая
    var parrot: Parrot? { get }
    /// Нажатия на кнопку назад
    func tapGoBack()
    /// Нажатие на кнопку
    func openYoutube(with urlString: String)
}

/// Слой презентации модуля DetailInfo
final class DetailInfoPresenter {
    private let imageDownloadService: ImageDownloadServiceProtocol
    private let router: DetailInfoRouting
    private(set) var parrot: Parrot?
    
    init(imageDownloadService: ImageDownloadServiceProtocol = ImageDownloadService(),
         router: DetailInfoRouting,
         parrot: Parrot?) {
        self.imageDownloadService = imageDownloadService
        self.router = router
        self.parrot = parrot
    }
}

// MARK: - DetailInfoPresentation
extension DetailInfoPresenter: DetailInfoPresentation {
    func tapGoBack() {
        router.popToRoot()
    }
    
    func getParrotImage(url: String,
                        completion: @escaping (Result<Data, DataFetcherError>) -> Void) {
        imageDownloadService.getData(from: url, responce: completion)
    }
    
    func openYoutube(with urlString: String) {
        router.routeToYoutube(urlString: urlString)
    }
}
