//
//  PhotosTableViewModelType.swift
//  FlickrApp
//
//  Created by Alper Akinci on 05/01/2018.
//  Copyright © 2018 Alper Akinci. All rights reserved.
//

import RxSwift

protocol PhotosTableViewModelType {
    var title: Observable<String> { get }
    var imageURL: URL { get }
}
