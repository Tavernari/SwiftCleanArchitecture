//
//  GitPullRequestsViewModel.swift
//  Presentation
//
//  Created by Victor C Tavernari on 08/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Domain

enum GitPullRequestViewModelRoute: Equatable {
    case none
    case showPullRequestDetail(id: Int, repo: GitRepository)
}

protocol GitPullRequestsViewModelInput {
    func select(index: Int)
    func load(repo: GitRepository)
}

protocol GitPullRequestsViewModelOutput {
    var pullRequests: Observable<[GitPullRequest]> { get }
    var status: Observable<ViewModelLoadStatus> { get }
    var route: Observable<GitPullRequestViewModelRoute> { get }
}

protocol GitPullRequestsViewModel : GitPullRequestsViewModelInput, GitPullRequestsViewModelOutput { }

class GitListPullRequestViewModel: GitPullRequestsViewModel {
    var pullRequests = Observable<[GitPullRequest]>([])
    var status = Observable<ViewModelLoadStatus>(.none)
    var route = Observable<GitPullRequestViewModelRoute>(.none)

    private let listPullRequestsUseCase: ListPullRequestsUseCase
    init(listPullRequestsUseCase: ListPullRequestsUseCase) {
        self.listPullRequestsUseCase = listPullRequestsUseCase
    }

    private var gitPullRequests = [GitPullRequest]()
    private var gitRepository:GitRepository!

    private func onReceivedPullRequests(pullRequests: [GitPullRequest]) {
        self.gitPullRequests = pullRequests
        self.status.value = .loaded
        self.pullRequests.value = pullRequests
    }

    private func onReceivedError(error: Error) {
        self.status.value = .fail(error.localizedDescription)
    }

    func load(repo: GitRepository) {
        self.status.value = .loading
        self.gitRepository = repo
        self.listPullRequestsUseCase.execute(repo: repo) { (result) in
            switch result {
            case .success(let data):
                self.onReceivedPullRequests(pullRequests: data)
            case .failure(let error):
                self.onReceivedError(error: error)
            }
        }
    }

    func select(index: Int) {
        let pullRequest = self.gitPullRequests[index]
        self.route.value = .showPullRequestDetail(id: pullRequest.id, repo: gitRepository)
    }
}
