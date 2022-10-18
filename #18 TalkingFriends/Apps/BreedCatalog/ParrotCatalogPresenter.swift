//
//  ParrotCatalogPresenter.swift
//  #18 TalkingFriends
//
//  Created by Владимир Рубис on 16.10.2022.
//

import UIKit

protocol ParrotCatalogPresentation {
    
    var parrots: [Parrot]? { get }
    func getParrots()
    func tapDetail(parrot: Parrot)
}

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
    
    func tapDetail(parrot: Parrot) {
        router.showDetail(parrot: parrot)
    }
}
