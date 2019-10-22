//
//  SearchCircleViewController.swift
//  TechBookFest
//
//  Created by 長田卓馬 on 2019/10/23.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import Foundation
import UIKit
import Nuke
import RxSwift
import DiffableDataSources

enum Section {
    case main
}

final class SearchCircleViewController: UIViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    private var viewModel: SearchCircleViewModelType!
    private var circles: [Circle] = []
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.register(UINib(nibName: CircleCell.className, bundle: nil), forCellReuseIdentifier: CircleCell.className)
        
        viewModel.outputs.circles
            .observeOn(MainScheduler.instance)
            .subscribe({ [weak self] nextValue in
                guard
                    let strongSelf = self,
                    let circles = nextValue.element
                    else { return }
                strongSelf.circles = circles
                strongSelf.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        search(filter: "")
    }
    
    private lazy var dataSource = TableViewDiffableDataSource<Section, Circle>(tableView: tableView) { tableView, indexPath, circle in
        let cell = tableView.dequeueReusableCell(withIdentifier: CircleCell.className, for: indexPath) as! CircleCell
        cell.titleLabel.text = circle.circle
        cell.discriptionLabel.text = circle.keyword
        Nuke.loadImage(with: URL(string: circle.circleImage)!, into: cell.thumbnailImageView)
        return cell
    }
}

// MARK: - UISearchBarDelegate

extension SearchCircleViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(filter: searchText)
    }
    
    func search(filter: String) {
        let circleArray = circles.lazy
            .filter { $0.contains(filter) }
            .sorted { $0.circle < $1.circle }

        var snapshot = DiffableDataSourceSnapshot<Section, Circle>()
        snapshot.appendSections([.main])
        snapshot.appendItems(circleArray)
        dataSource.apply(snapshot)
    }
}

// MARK: - UITableViewDelegate

extension SearchCircleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let circle = circles[indexPath.row]
        let url = URL(string: circle.circleURL)!
        let vc = DetailViewController.make(with: DetailViewModel(url: url))
        self.present(vc, animated: true, completion: nil)
    }
}

// MARK: - StoryboardInstantiable

extension SearchCircleViewController: StoryboardInstantiable {
    
    static func make(with viewModel: SearchCircleViewModel) -> SearchCircleViewController {
        let view = SearchCircleViewController.instantiate()
        view.viewModel = viewModel
        return view
    }
}
