//
//  PhotoTableViewModel.swift
//  FlickrApp
//
//  Created by Alper Akinci on 05/01/2018.
//  Copyright © 2018 Alper Akinci. All rights reserved.
//

import RxSwift

final class PhotoTableViewModel: PhotosTableViewModelType {

    let title: Observable<String>

    init(item: PhotoItem) {
        // You can also make title in model optional
        title = Observable.just(item.title)
    }
}
