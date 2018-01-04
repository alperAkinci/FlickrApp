//
//  PhotosInfo.swift
//  FlickrApp
//
//  Created by Alper Akinci on 04/01/2018.
//  Copyright © 2018 Alper Akinci. All rights reserved.
//

import Foundation
import Mapper

struct PhotosInfo: Mappable {

    var page: Int
    var pages: Int
    var perPage: Int
    var photo: [PhotoItem]?
    var total: Int

    init(map: Mapper) throws {
        try page = map.from("photos.page")
        try pages = map.from("photos.pages")
        try perPage = map.from("photos.perPage")
        photo = map.optionalFrom("photos.photo")
        try total = map.from("photos.total")
    }
}
