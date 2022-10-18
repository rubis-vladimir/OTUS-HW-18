//
//  DetailInfoPresenter.swift
//  #18 TalkingFriends
//
//  Created by Владимир Рубис on 16.10.2022.
//


import UIKit

protocol DetailInfoPresentation {
    var parrot: Parrot? { get }
}

final class DetailInfoPresenter {
    
    weak var delegate: DetailInfoPresenterDelegate?
    
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

extension DetailInfoPresenter: DetailInfoPresentation {
    
}
