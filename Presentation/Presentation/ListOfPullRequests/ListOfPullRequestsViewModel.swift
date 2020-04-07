//
//  ListOfPullRequestsViewModel.swift
//  Presentation
//
//  Created by Victor C Tavernari on 04/04/20.
//  Copyright (c) 2020 Taverna Apps. All rights reserved.
//
//  This file was generated by Mobiplus Clean
//

import Domain

class ListOfPullRequestsViewModel: ListOfPullRequestsViewModelInterface {
    var route = Observable<ListOfPullRequestsViewModelRoute>(.none)
    var pullRequests = Observable<[GitPullRequest]>([])
    var isLoading = Observable<Bool>(false)
    var failMessage = Observable<String?>(nil)

    private let listPullRequestsUseCase: FetchPullRequestsUseCaseInterface
    init(listPullRequestsUseCase: FetchPullRequestsUseCaseInterface) {
        self.listPullRequestsUseCase = listPullRequestsUseCase
    }

    private var gitRepository: GitRepository!

    func load(repo: GitRepository) {
        gitRepository = repo
        listPullRequestsUseCase.execute(repo: repo)
    }

    func select(index: Int) {
        let pullRequest = pullRequests.value[index]
        route.value = .showPullRequestDetail(id: pullRequest.id, repo: gitRepository)
    }
}

extension ListOfPullRequestsViewModel: FetchPullRequestsInterfaceAdapter {
    func doing() {
        isLoading.value = true
    }

    func done(data: [GitPullRequest]) {
        pullRequests.value = data
        isLoading.value = false
    }

    func failure(error: Error) {
        failMessage.value = error.localizedDescription
    }
}