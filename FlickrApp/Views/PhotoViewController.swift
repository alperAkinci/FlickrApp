//
//  ViewController.swift
//  FlickrApp
//
//  Created by Alper Akinci on 02/01/2018.
//  Copyright © 2018 Alper Akinci. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Moya

class PhotoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let disposeBag = DisposeBag()
    var provider: MoyaProvider<Flickr>!
    var viewModel: PhotoViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "PhotoTableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PhotoCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        
        setupBindings()
        viewModel?.searchPhoto()
    }

    func setupBindings() {
        // Firstly create Provider
        provider = MoyaProvider<Flickr>()

        viewModel = PhotoViewModel()

        viewModel
            .photosObservable
            .bind(to: tableView.rx.items){ tableView, row, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: IndexPath(row: row, section: 0)) as! PhotoTableCell
            cell.viewModel = item
            return cell
            }.disposed(by: disposeBag)

    }
}

