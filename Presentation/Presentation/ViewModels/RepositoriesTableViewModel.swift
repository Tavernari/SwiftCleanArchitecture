//
//  RepositoriesTableViewModel.swift
//  Presentation
//
//  Created by Victor C Tavernari on 06/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation
import Domain

enum GitRepositoriesListRoute: Equatable {
    case none
    case showPullRequests(repo: GitRepository)
}

protocol GitRepositoriesListViewModelInput {
    func search(term: String)
    func select(index: Int)
}

protocol GitRepositoriesListViewModelOutput {
    var status: Observable<ViewModelLoadStatus> { get }
    var repositories: Observable<[GitRepository]> { get }
    var route: Observable<GitRepositoriesListRoute> { get }
}

protocol GitRepositoriesListViewModel : GitRepositoriesListViewModelInput, GitRepositoriesListViewModelOutput { }

class RepositoriesTableViewModel : GitRepositoriesListViewModel {
    var status = Observable<ViewModelLoadStatus>(.none)
    var repositories = Observable<[GitRepository]>([])
    var route = Observable<GitRepositoriesListRoute>(.none)


    private let listGitRepositoryUseCase: ListGitRepositoryUseCase
    public init(listGitRepositoryUseCase: ListGitRepositoryUseCase) {
        self.listGitRepositoryUseCase = listGitRepositoryUseCase
    }

    private var memoryRepositories = [GitRepository]()

    func search(term: String) {
        self.status.value = .loading
        self.listGitRepositoryUseCase.execute(term: term) { (result) in
            switch result {
            case .success(let data):
                self.memoryRepositories = data
                self.status.value = .loaded
                self.repositories.value = data
            case .failure(let error):
                self.status.value = .fail(error.localizedDescription)
            }
        }
    }

    func select(index: Int) {
        let repository = self.memoryRepositories[index]
        self.route.value = .showPullRequests(repo: repository)
    }
}
