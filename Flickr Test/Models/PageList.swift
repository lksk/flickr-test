//
//  PageList.swift
//  Flickr Test
//
//  Created by Lakshmikantha H on 7/17/18.
//  Copyright © 2018 Lakshmikantha H. All rights reserved.
//

import ObjectMapper

class PageList: ImmutableMappable {
    let photos: PhotosDetail
    
    required init(map: Map) throws {
        photos = try map.value("photos")
    }
}

extension PageList: Equatable {
    static func == (lhs: PageList, rhs: PageList) -> Bool {
        return lhs.photos == rhs.photos
    }
}
