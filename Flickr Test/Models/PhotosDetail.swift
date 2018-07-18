//
//  PhotosDetail.swift
//  Flickr Test
//
//  Created by Lakshmikantha H on 7/17/18.
//  Copyright © 2018 Lakshmikantha H. All rights reserved.
//

import ObjectMapper

class PhotosDetail: ImmutableMappable {
    let photo: [Image]
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    
    required init(map: Map) throws {
        photo = try map.value("photo")
        page     = try map.value("page")
        pages    = try map.value("pages")
        perpage    = try map.value("perpage")
        total      = try map.value("total")
    }
}

extension PhotosDetail: Equatable {
    static func == (lhs: PhotosDetail, rhs: PhotosDetail) -> Bool {
        return lhs.photo == rhs.photo
            && lhs.page == rhs.page
            && lhs.pages == rhs.pages
            && lhs.perpage == rhs.perpage
            && lhs.total == rhs.total
    }
}
