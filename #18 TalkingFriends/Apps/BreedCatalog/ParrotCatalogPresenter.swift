//
//  ParrotCatalogPresenter.swift
//  #18 TalkingFriends
//
//  Created by Владимир Рубис on 16.10.2022.
//

import Foundation

/// Протокол управления UI-ивентами модуля ParrotCatalog
protocol ParrotCatalogPresentation: ImageDownloadable {
    /// Массив попугаев
    var parrots: [Parrot]? { get }
    /// Получает данные по попугаям
    func getParrots()
    /// Передача касания к роутеру
    func tapDetail(parrot: Parrot)
}

/// Слой презентации модуля ParrotCatalog
final class ParrotCatalogPresenter {
    weak var delegate: ParrotCatalogPresenterDelegate?
    
    private let router: ParrotCatalogRouting
    private let dataFetcherService: DataFetcherService = DataFetcherService()
    private let imageDownloadService: ImageDownloadServiceProtocol
    
    private(set) var parrots: [Parrot]? {
        didSet {
            delegate?.updateUI()
        }
    }
    
    init(router: ParrotCatalogRouting,
        imageDownloadService: ImageDownloadServiceProtocol = ImageDownloadService()) {
        self.router = router
        self.imageDownloadService = imageDownloadService
    }
}

// MARK: - ParrotCatalogPresentation
extension ParrotCatalogPresenter: ParrotCatalogPresentation {
    func getParrots() {
        dataFetcherService.fetchParrots { result in
            switch result {
            case .success(let parrots):
                self.parrots = parrots
            case .failure(let error):
                self.delegate?.showError(error)
            }
        } 
    }
    
    func getParrotImage(url: String, completion: @escaping (Result<Data, DataFetcherError>) -> Void) {
        imageDownloadService.getData(from: url, responce: completion)
    }
    
    func tapDetail(parrot: Parrot) {
        router.showDetail(parrot: parrot)
    }
}
