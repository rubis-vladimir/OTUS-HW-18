//
//  DataFetcherService.swift
//  #18 TalkingFriends
//
//  Created by Владимир Рубис on 16.10.2022.
//

import Foundation

// MARK: Сервис получения данных
final class DataFetcherService {
    
    var dataFetcher: DataFetcherProtocol
    
    init(dataFetcher: DataFetcherProtocol = LocalDataFetcher()) {
        self.dataFetcher = dataFetcher
    }
    
    /// Возвращает массив данных разработчиков, декодированный
    /// из локально расположенного файла JSON
    func fetchParrots(completion: @escaping (Result<[Parrot], DataFetcherError>) -> Void) {
        let localUrl = "parrots.json"
        dataFetcher.fetchJSONData(from: localUrl, responce: completion)
    }
}
