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
        try page = map.from("page")
        try pages = map.from("pages")
        try perPage = map.from("perPage")
        photo = map.optionalFrom("photo")
        try total = map.from("total")
    }
}
