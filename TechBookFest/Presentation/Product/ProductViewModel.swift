//
//  ProductViewModel.swift
//  TechBookFest
//
//  Created by 長田卓馬 on 2019/10/23.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import Alamofire
import SwiftyJSON

protocol ProductViewModelInputs {
}

protocol ProductViewModelOutputs {
    var products: Observable<[Product]> { get }
}

protocol ProductViewModelType: ProductViewModelInputs, ProductViewModelOutputs {
    var inputs: ProductViewModelInputs { get }
    var outputs: ProductViewModelOutputs { get }
}

class ProductViewModel: ProductViewModelType {
    
    // MARK: - Inputs
    var inputs: ProductViewModelInputs { return self }

    // MARK: - Outputs
    var outputs: ProductViewModelOutputs { return self }
    let products: Observable<[Product]>
    
    private var repository: ProductRepository!
    
    init(repository: ProductRepositoryImpl) {
        self.repository = repository
        repository.fetchProducts()
        self.products = repository.result.asObservable()
    }
}
