//
//  RepositoriesTableViewModel.swift
//  Presentation
//
//  Created by Victor C Tavernari on 06/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation
import Domain
import RxSwift

enum GitRepositoriesListRoute: Equatable {
    case none
    case showPullRequests(owner: String, repository: String)
}

enum GitRepositoriesListStatus: Equatable {
    case loading
    case loaded
    case fail(String)
}

protocol GitRepositoriesListViewModelInput {
    var search: PublishSubject<String> { get }
    var select: PublishSubject<Int> { get }
}

protocol GitRepositoriesListViewModelOutput {
    var status: Observable<GitRepositoriesListStatus> { get }
    var repositories: Observable<[Repository]> { get }
    var route: Observable<GitRepositoriesListRoute> { get }
}

protocol GitRepositoriesListViewModel : GitRepositoriesListViewModelInput, GitRepositoriesListViewModelOutput { }

class RepositoriesTableViewModel : GitRepositoriesListViewModel {
    lazy var select: PublishSubject<Int> = {
        let selectSubject = PublishSubject<Int>()
        selectSubject
            .subscribe(onNext: self.selected)
            .disposed(by: self.disposeBag)
        return selectSubject
    }()

    lazy var search: PublishSubject<String> = {
        let searchSubject = PublishSubject<String>()
        searchSubject
            .do(onNext: { _ in self.statusSubject.onNext(.loading) })
            .subscribe(onNext: { self.search(term: $0 ) })
            .disposed(by: self.disposeBag)
        return searchSubject
    }()

    private let gitRepository: GitRepoRepository
    public init(gitRepository: GitRepoRepository) {
        self.gitRepository = gitRepository
    }

    private let disposeBag = DisposeBag()

    private var statusSubject = PublishSubject<GitRepositoriesListStatus>()
    var status: Observable<GitRepositoriesListStatus> { statusSubject }

    private var repositoriesSubject = PublishSubject<[Repository]>()
    var repositories: Observable<[Repository]> { repositoriesSubject }

    private var errorSubject = PublishSubject<String>()
    var error: Observable<String> { errorSubject }

    private var routeSubject = PublishSubject<GitRepositoriesListRoute>()
    var route: Observable<GitRepositoriesListRoute> { routeSubject }

    private var memoryRepositories = [Repository]()

    private func search(term: String) {
        try? ListRepositoriesUseCase(repository: gitRepository)
            .with(input: term)
            .run()
            .do(onNext: { self.memoryRepositories = $0 })
            .subscribe { (event) in
                switch event {
                case .next(let repositories):
                    self.repositoriesSubject.onNext(repositories)
                    self.statusSubject.onNext(.loaded)
                case .error(let error):
                    self.statusSubject.onNext(.fail(error.localizedDescription))
                default:
                    break
                }
        }.disposed(by: self.disposeBag)
    }

    private func selected(itemIndex: Int) {
        let repository = self.memoryRepositories[itemIndex]
        routeSubject.onNext(.showPullRequests(owner: repository.author, repository: repository.name))
    }
}
