//
//  DetailViewModel.swift
//  TechBookFest
//
//  Created by 長田卓馬 on 2019/10/22.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Action
import APIKit

protocol DetailViewModelInputs {}

protocol DetailViewModelOutputs {
    var request: URLRequest { get }
}

protocol DetailViewModelType: DetailViewModelInputs, DetailViewModelOutputs {
    var inputs: DetailViewModelInputs { get }
    var outputs: DetailViewModelOutputs { get }
}

final class DetailViewModel: DetailViewModelType {

    // MARK: - Inputs
    var inputs: DetailViewModelInputs { return self }

    // MARK: - Outputs
    var outputs: DetailViewModelOutputs { return self }
    let request: URLRequest

    private let disposeBag = DisposeBag()

    init(url: URL) {
        self.request = URLRequest(url: url)
    }

}
