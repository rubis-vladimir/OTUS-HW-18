//
//  Parrot.swift
//  #18 TalkingFriends
//
//  Created by Владимир Рубис on 16.10.2022.
//

import Foundation

struct Parrot: Decodable {
    var breed: String
    var habitat: String
    var size: Int
    var interestingFact: String
    var imageStringNames: [String]
    var videoUrlString: String
}
