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

        
    }
}

extension DetailInfoViewController: DetailInfoPresenterDelegate {
    
}
