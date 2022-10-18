//
//  ImageDownloadable.swift
//  #18 TalkingFriends
//
//  Created by Владимир Рубис on 18.10.2022.
//

import Foundation

/// Протокол загрузки изображений
protocol ImageDownloadable: AnyObject {
    /// Загружает изображение
    ///  - Parameters:
    ///   - url: ссылка
    ///   - completion: захватывает данные/ошибку
    func getParrotImage(url: String, completion: @escaping (Result<Data, DataFetcherError>) -> Void)
}
