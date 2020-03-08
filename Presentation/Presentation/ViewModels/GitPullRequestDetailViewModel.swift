//
//  GitPullRequestDetailViewModel.swift
//  Presentation
//
//  Created by Victor C Tavernari on 08/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Domain

struct GitPullRequestDetailViewModelInputData {
    public var repo: GitRepository!
    public var id: Int!
}
protocol GitPullRequestDetailViewModelInput {
    func load(data: GitPullRequestDetailViewModelInputData)
}

protocol GitPullRequestDetailViewModelOutput {
    var pullRequest: Observable<GitPullRequest> { get }
    var status: Observable<ViewModelLoadStatus> { get }
}

protocol GitPullRequestDetailViewModel: GitPullRequestDetailViewModelInput, GitPullRequestDetailViewModelOutput {}

class PullRequestDetailViewModel: GitPullRequestDetailViewModel {
    var pullRequest = Observable<GitPullRequest>(GitPullRequest())
    var status = Observable<ViewModelLoadStatus>(.none)

    private let useCase: GetPullRequestDetailUseCase
    init(useCase: GetPullRequestDetailUseCase) {
        self.useCase = useCase
    }

    func load(data: GitPullRequestDetailViewModelInputData) {
        self.status.value = .loading
        self.useCase.execute(id: data.id, fromRepo: data.repo) { (result) in
            switch result {
            case .success(let data):
                self.status.value = .loaded
                self.pullRequest.value = data
            case .failure(let error):
                self.status.value = .fail(error.localizedDescription)
            }
        }
    }

}
