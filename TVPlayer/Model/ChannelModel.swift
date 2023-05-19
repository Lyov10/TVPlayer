//
//  ChannelModel.swift
//  TVPlayer
//
//  Created by 4steps on 19.05.23.
//

import Foundation

struct ChanellList: Codable {
    let channels: [ChannelModel]
}

struct ChannelModel: Codable {
    let id: Int
    let name: String
    let image: String
    let current: CurrentShow
    private enum CodingKeys : String, CodingKey {
        case name = "name_ru", id, image,current
    }
}

struct CurrentShow: Codable {
    let title: String?
    let description: String?
    let time: Int
    private enum CodingKeys : String, CodingKey {
        case description = "desc", time = "timestop", title
    }
}

