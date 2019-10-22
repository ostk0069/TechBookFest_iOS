//
//  HomeViewModel.swift
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

protocol HomeViewModelInputs {
    var fetchTrigger: PublishSubject<Void> { get }
}

protocol HomeViewModelOutputs {
    var gitHubRepositories: Observable<[GitHubRepository]> { get }
    var isLoading: Observable<Bool> { get }
    var error: Observable<NSError> { get }
}

protocol HomeViewModelType: HomeViewModelInputs, HomeViewModelOutputs {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

final class HomeViewModel: HomeViewModelType {

    // MARK: - Inputs
    var inputs: HomeViewModelInputs { return self }
    let fetchTrigger = PublishSubject<Void>()
    private let page = BehaviorRelay<Int>(value: 1)

    // MARK: - Outputs
    var outputs: HomeViewModelOutputs { return self }
    let gitHubRepositories: Observable<[GitHubRepository]>
    let isLoading: Observable<Bool>
    let error: Observable<NSError>

    private let searchAction: Action<Int, [GitHubRepository]>
    private let disposeBag = DisposeBag()

    init(language: String) {
        self.searchAction = Action { page in
            return Session.shared.rx.response(
                GitHubApi.SearchRequest(language: language, page: page))
        }
        let response = BehaviorRelay<[GitHubRepository]>(value: [])
        self.gitHubRepositories = response.asObservable()

        self.isLoading = searchAction.executing.startWith(false)
        self.error = searchAction.errors.map { _ in
            NSError(domain: "Network Error", code: 0, userInfo: nil)
        }

        searchAction.elements
            .withLatestFrom(response) { ($0, $1) }
            .map { $0.1 + $0.0 }
            .bind(to: response)
            .disposed(by: disposeBag)

        searchAction.elements
            .withLatestFrom(page)
            .map { $0 + 1 }
            .bind(to: page)
            .disposed(by: disposeBag)

        fetchTrigger
            .withLatestFrom(page)
            .bind(to: searchAction.inputs)
            .disposed(by: disposeBag)
    }

}
