//
//  GitRepositoriesListViewModel.swift
//  Presentation
//
//  Created by Victor C Tavernari on 04/04/20.
//  Copyright (c) 2020 Taverna Apps. All rights reserved.
//
//  This file was generated by Mobiplus Clean
//

import DomainLayer

// sourcery: AutoMockable
protocol GitRepositoriesListViewModelAnalyticsProtocol {
    func itemSelected(name: String)
    func searched(term: String)
    func screen()
}

class GitRepositoriesListViewModel: GitRepositoriesListViewModelInterface {
    var isLoading = Observable<Bool>(false)
    var failMessage = Observable<String?>(nil)
    var repositories = Observable<[GitRepositoryModel]>([])
    var route = Observable<GitRepositoriesListViewModelRoute>(.none)

    let delegateAnalyticsInterface: GitRepositoriesListViewModelAnalyticsProtocol

    private let fetchGitRepositoriesUseCase: FetchGitRepositoriesUseCaseProtocol

    init(fetchGitRepositoriesUseCase: FetchGitRepositoriesUseCaseProtocol,
         delegateAnalyticsInterface: GitRepositoriesListViewModelAnalyticsProtocol) {
        self.fetchGitRepositoriesUseCase = fetchGitRepositoriesUseCase
        self.delegateAnalyticsInterface = delegateAnalyticsInterface

        // NAO ESTOU CONVENCIDO DESTA SER A MELHOR MANEIRA DE TRACK DE SCREEN
        self.delegateAnalyticsInterface.screen()
    }

    func search(term: String) {
        delegateAnalyticsInterface.searched(term: term)
        fetchGitRepositoriesUseCase.execute(term: term)
    }

    func select(index: Int) {
        let repository = repositories.value[index]

        AppEvents.gitRepoSelected(repoName: repository.name).dispatch()

        delegateAnalyticsInterface.itemSelected(name: repository.name)
        route.value = .showPullRequests(repo: repository)
    }
}

extension GitRepositoriesListViewModel: FetchGitRepositoriesInterfaceAdapter {
    func doing() {
        isLoading.value = true
    }

    func done(data: [GitRepositoryModel]) {
        isLoading.value = false
        repositories.value = data
    }

    func failure(withError error: FetchGitRepositoriesError) {
        switch error {
        case .termCannotBeEmpty:
            failMessage.value = "Term cannot be empty"
        case .urlError(.noInternetConnection):
            failMessage.value = "Caiu a internet"
        case .urlError(.timeOut):
            failMessage.value = "Time out"
        case let .urlError(.generic(message)):
            route.value = .showError(errorMessage: message)
        }

        isLoading.value = false
    }
}
