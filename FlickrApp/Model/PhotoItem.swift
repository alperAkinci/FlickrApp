//
//  PhotoItem.swift
//  FlickrApp
//
//  Created by Alper Akinci on 04/01/2018.
//  Copyright © 2018 Alper Akinci. All rights reserved.
//

import Foundation
import Mapper

struct PhotoItem: Mappable {

    var id: String
    var server: String
    var secret: String
    var title: String

    init(map: Mapper) throws {
        try id = map.from("id")
        try server = map.from("server")
        try secret = map.from("secret")
        try title = map.from("title")
    }

}
