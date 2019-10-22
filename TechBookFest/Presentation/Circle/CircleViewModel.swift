//
//  CircleViewModel.swift
//  TechBookFest
//
//  Created by 長田卓馬 on 2019/10/22.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import Action
import APIKit

protocol CircleViewModelInputs {}

protocol CircleViewModelOutputs {
    var circles: Observable<[Circle]> { get }
}

protocol CircleViewModelType: CircleViewModelInputs, CircleViewModelOutputs {
    var inputs: CircleViewModelInputs { get }
    var outputs: CircleViewModelOutputs { get }
}

final class CircleViewModel: CircleViewModelType {

    // MARK: - Inputs
    var inputs: CircleViewModelInputs { return self }

    // MARK: - Outputs
    var outputs: CircleViewModelOutputs { return self }
    let circles: Observable<[Circle]>

    private let disposeBag = DisposeBag()

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
