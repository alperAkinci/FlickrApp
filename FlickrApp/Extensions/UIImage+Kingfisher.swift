//
//  UIImage+Kingfishrer.swift
//  FlickrApp
//
//  Created by Alper Akinci on 09/01/2018.
//  Copyright © 2018 Alper Akinci. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func download(imageURL url: URL) {
        self.kf.setImage(with: ImageResource(downloadURL: url))
    }
}
