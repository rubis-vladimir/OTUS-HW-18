//
//  Assemblying.swift
//  #18 TalkingFriends
//
//  Created by Владимир Рубис on 16.10.2022.
//

import UIKit

/// Протокол компоновки VIPER-модулей на базе UIViewController
protocol Assemblying {
    
    /// Собрать VIPER-модуль
    ///  - Returns: UIViewController компонующего модуля
    func assembly() -> UIViewController
}
