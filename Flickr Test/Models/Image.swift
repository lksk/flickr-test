//
//  Image.swift
//  Flickr Test
//
//  Created by Lakshmikantha H on 7/17/18.
//  Copyright © 2018 Lakshmikantha H. All rights reserved.
//

import ObjectMapper

class Image: ImmutableMappable, Codable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int
    
    required init(map: Map) throws {
        id        = try map.value("id")
        owner     = try map.value("owner")
        secret    = try map.value("secret")
        server    = try map.value("server")
        farm      = try map.value("farm")
        title     = try map.value("title")
        ispublic  = try map.value("ispublic")
        isfriend  = try map.value("isfriend")
        isfamily  = try map.value("isfamily")
    }
}

extension Image: Equatable {
    static func == (lhs: Image, rhs: Image) -> Bool {
        return lhs.id == rhs.id
            && lhs.owner == rhs.owner
            && lhs.secret == rhs.secret
            && lhs.server == rhs.server
            && lhs.farm == rhs.farm
            && lhs.title == rhs.title
            && lhs.ispublic == rhs.ispublic
            && lhs.isfriend == rhs.isfriend
            && lhs.isfamily == rhs.isfamily
    }
}

