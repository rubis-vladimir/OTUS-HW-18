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
    var size: String
    var interestingFact: String
    var contentFeatures: String
    var images: [String]
    var video: String
}
