//
//  CircleApi.swift
//  TechBookFest
//
//  Created by 長田卓馬 on 2019/10/23.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxRelay
import SwiftyJSON

struct Product: Hashable {
    let id: String
    let circleID: String
    let name: String
    let description: String
    let imageURL: String
    
    init(id: String, circleID: String, name: String, description: String, imageURL: String) {
        self.id = id
        self.circleID = circleID
        self.name = name
        self.description = description
        self.imageURL = imageURL
    }
    
    func contains(_ filter: String) -> Bool {
        guard !filter.isEmpty else {
            return true
        }

        let lowercasedFilter = filter.lowercased()
        return name.lowercased().contains(lowercasedFilter)
    }
}

protocol ProductRepository {
    
    func fetchProducts()
}

final class ProductRepositoryImpl: ProductRepository {
    
    private let urlString = "https://techbookfest.org/api/products/own?eventID=tbf07&limit=2000"
    
    var result = BehaviorRelay<[Product]>(value: [])
        
    func fetchProducts() {
        let url = URL(string: urlString)!
        Alamofire.request(url, method: .get).responseJSON(completionHandler: { response in
            switch response.result {
            case .success:
                let json: JSON = JSON(response.result.value ?? kill)
                let listJson: JSON = json["list"]
                let products = listJson.map { (index, list) -> Product in
                    let id: String = list["id"].string ?? ""
                    let circleID: String = list["circleExhibitInfoID"].string ?? ""
                    let name: String = list["name"].string ?? ""
                    let description: String = list["description"].string ?? ""
                    let imageURL: String = list["images"][0]["url"].string ?? ""
                    let product = Product(id: id, circleID: circleID, name: name, description: description, imageURL: imageURL)
                    return product
                }
                self.result.accept(products)
            case .failure(let error):
                print(error)
            }
        })
    }
}
