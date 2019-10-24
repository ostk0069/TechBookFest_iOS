//
//  ProductViewController.swift
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

final class ProductViewController: UIViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    private var viewModel: ProductViewModelType!
    private var products: [Product] = []
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.register(UINib(nibName: CircleCell.className, bundle: nil), forCellReuseIdentifier: CircleCell.className)
        
        viewModel.outputs.products
            .observeOn(MainScheduler.instance)
            .subscribe({ [weak self] nextValue in
                guard
                    let strongSelf = self,
                    let products = nextValue.element
                    else { return }
                strongSelf.products = products
                strongSelf.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        search(filter: "")
    }
    
    private lazy var dataSource = TableViewDiffableDataSource<Section, Product>(tableView: tableView) { tableView, indexPath, product in
        let cell = tableView.dequeueReusableCell(withIdentifier: CircleCell.className, for: indexPath) as! CircleCell
        cell.titleLabel.text = product.name
        cell.discriptionLabel.text = product.description
        if !product.imageURL.isEmpty {
            Nuke.loadImage(with: URL(string: product.imageURL)!, into: cell.thumbnailImageView)
        }
        return cell
    }
}

// MARK: - UISearchBarDelegate

extension ProductViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(filter: searchText)
    }
    
    func search(filter: String) {
        let circleArray = products.lazy
            .filter { $0.contains(filter) }
            .sorted { $0.name < $1.name }

        var snapshot = DiffableDataSourceSnapshot<Section, Product>()
        snapshot.appendSections([.main])
        snapshot.appendItems(circleArray)
        dataSource.apply(snapshot)
    }
}

// MARK: - UITableViewDelegate

extension ProductViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let product = products[indexPath.row]
        let url = URL(string: "https://techbookfest.org/event/tbf07/circle/\(product.circleID)")!
        let vc = DetailViewController.make(with: DetailViewModel(url: url))
        self.present(vc, animated: true, completion: nil)
    }
}

// MARK: - StoryboardInstantiable

extension ProductViewController: StoryboardInstantiable {
    
    static func make(with viewModel: ProductViewModel) -> ProductViewController {
        let view = ProductViewController.instantiate()
        view.viewModel = viewModel
        return view
    }
}
