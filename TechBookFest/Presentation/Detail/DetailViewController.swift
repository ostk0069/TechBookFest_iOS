//
//  DetailViewController.swift
//  TechBookFest
//
//  Created by 長田卓馬 on 2019/10/22.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import WebKit
import RxWebKit

final class DetailViewController: UIViewController {

    @IBOutlet private weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var webView: WKWebView!

    private var viewModel: DetailViewModelType!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.rx.loading
            .observeOn(MainScheduler.asyncInstance)
            .bind(to: indicatorView.rx.isAnimating)
            .disposed(by: disposeBag)

        webView.load(viewModel.outputs.request)
    }
}

// MARK: - StoryboardInstantiable

extension DetailViewController: StoryboardInstantiable {
    
    static func make(with viewModel: DetailViewModel) -> DetailViewController {
        let view = DetailViewController.instantiate()
        view.viewModel = viewModel
        return view
    }
}
