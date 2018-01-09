//
//  PhotoTableCell.swift
//  FlickrApp
//
//  Created by Alper Akinci on 02/01/2018.
//  Copyright © 2018 Alper Akinci. All rights reserved.
//

import UIKit
import RxSwift

class PhotoTableCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    private var disposeBag = DisposeBag()

    var viewModel: PhotosTableViewModelType? {
        willSet {
            disposeBag = DisposeBag()
        }
        didSet {
            setupBindings()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.kf.cancelDownloadTask()
        photoImageView.image = nil
    }

    func setupBindings() {
        guard let viewModel = viewModel, let titleLabel = titleLabel else { return }
        viewModel.title.bind(to: titleLabel.rx.text).disposed(by: disposeBag)
        photoImageView.download(imageURL: viewModel.imageURL)
    }
}
