//
//  File.swift
//  FlickrApp
//
//  Created by Alper Akinci on 02/01/2018.
//  Copyright © 2018 Alper Akinci. All rights reserved.
//

import Foundation
import Moya
import Mapper
import Moya_ModelMapper
import RxOptional
import RxSwift


protocol PhotoViewModelType {
    var photosObservable: Observable<[PhotosTableViewModelType]> { get }
}

final class PhotoViewModel: PhotoViewModelType {

    private let provider =  MoyaProvider<Flickr>()
    private let photos = Variable<[(PhotoItem, PhotosTableViewModelType)]>([])
    let searchQuery: Observable<String> = Observable.of("Street") // Searched text
    private let disposeBag = DisposeBag()

    lazy var photosObservable: Observable<[PhotosTableViewModelType]> = self.photos.asObservable().map { $0.map { $0.1 } }


    func searchPhoto() {
        searchQuery
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (keyword) in
                self.searchPhoto(keyword: keyword)
            })
            .disposed(by: disposeBag)
    }

    private func searchPhoto(keyword: String) {
        self.provider
            .rx
            .request(Flickr.photoList(searchQuery: keyword))
            .debug()
            .asObservable()
            .mapOptional(to: [PhotoItem].self, keyPath: "photos.photo")
            .subscribe({ (photoItemsElement) in
                let photoItems = photoItemsElement.element!!
                self.photos.value = (photoItems.map({ ($0, PhotoTableViewModel(item: $0)) }))
            }).disposed(by: disposeBag)
    }

    func testPhotoRequest() {
       self.provider
            .rx
            .request(Flickr.photoList(searchQuery: "Street"))
            .debug()
            .asObservable()
        .subscribe(onNext: { (response) in
             print(response)
        }, onError: { (error) in
            print(error.localizedDescription)
        })
    }
}


