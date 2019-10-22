//
//  SearchCircleViewModel.swift
//  TechBookFest
//
//  Created by 長田卓馬 on 2019/10/23.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

protocol SearchCircleViewModelInputs {}

protocol SearchCircleViewModelOutputs {
    var circles: Observable<[Circle]> { get }
}

protocol SearchCircleViewModelType: SearchCircleViewModelInputs, SearchCircleViewModelOutputs {
    var inputs: SearchCircleViewModelInputs { get }
    var outputs: SearchCircleViewModelOutputs { get }
}

class SearchCircleViewModel: SearchCircleViewModelType {
    
    // MARK: - Inputs
    var inputs: SearchCircleViewModelInputs { return self }

    // MARK: - Outputs
    var outputs: SearchCircleViewModelOutputs { return self }
    let circles: Observable<[Circle]>
    
    init() {
        let response = BehaviorRelay<[Circle]>(value: [])
        do {
            let data = json.data(using: .utf8)!
            let res = try JSONDecoder().decode(CircleResponse.self, from: data)
            response.accept(res.circles)
        } catch {
            print(error)
        }
        self.circles = response.asObservable()
    }
}
