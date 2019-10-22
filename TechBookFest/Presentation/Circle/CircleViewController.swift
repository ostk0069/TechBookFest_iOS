//
//  CircleViewController.swift
//  TechBookFest
//
//  Created by 長田卓馬 on 2019/10/22.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import Nuke

final class CircleViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var viewModel: CircleViewModelType!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: CircleCell.className, bundle: nil), forCellReuseIdentifier: CircleCell.className)
        viewModel.outputs.circles
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: CircleCell.className, cellType: CircleCell.self)) { row, circle, cell in
                cell.titleLabel.text = circle.circle
                cell.discriptionLabel.text = circle.keyword
                Nuke.loadImage(with: URL(string: circle.circleImage)!, into: cell.thumbnailImageView)
            }
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(Circle.self)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] nextValue in
                let vc = DetailViewController.make(with: DetailViewModel(url: URL(string: nextValue.circleURL)!))
                self?.present(vc, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.indexPathsForSelectedRows?.forEach { [weak self] in
            self?.tableView.deselectRow(at: $0, animated: true)
        }
    }
}

// MARK: - StoryboardInstantiable

extension CircleViewController: StoryboardInstantiable {
    
    static func make(with viewModel: CircleViewModel) -> CircleViewController {
        let view = CircleViewController.instantiate()
        view.viewModel = viewModel
        return view
    }
}
