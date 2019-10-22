//
//  HomeViewController.swift
//  TechBookFest
//
//  Created by 長田卓馬 on 2019/10/22.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

final class HomeViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var indicatorView: UIActivityIndicatorView!
    
    private var viewModel: HomeViewModelType!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.outputs.gitHubRepositories
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items) { tableView, row, githubRepository in
                let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "subtitle")
                cell.textLabel?.text = "\(githubRepository.fullName)"
                cell.detailTextLabel?.textColor = UIColor.lightGray
                cell.detailTextLabel?.text = "\(githubRepository.description)"
                return cell
            }
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(GitHubRepository.self)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] nextValue in
                let vc = DetailViewController.make(with: DetailViewModel(url: nextValue.url))
                self?.present(vc, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)

        viewModel.outputs.isLoading
            .observeOn(MainScheduler.instance)
            .bind(to: indicatorView.rx.isAnimating)
            .disposed(by: disposeBag)

        viewModel.outputs.isLoading
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] nextValue in
                self?.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: nextValue ? 50 : 0, right: 0)
                if nextValue == false {
                    self?.indicatorView.isHidden = true
                }
            })
            .disposed(by: disposeBag)

        viewModel.outputs.error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                let ac = UIAlertController(title: "Error \($0)", message: nil, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(ac, animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.inputs.fetchTrigger.onNext(())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.indexPathsForSelectedRows?.forEach { [weak self] in
            self?.tableView.deselectRow(at: $0, animated: true)
        }
    }
}

extension HomeViewController: StoryboardInstantiable {
    
    static func make(with viewModel: HomeViewModel) -> HomeViewController {
        let view = HomeViewController.instantiate()
        view.viewModel = viewModel
        return view
    }
}
