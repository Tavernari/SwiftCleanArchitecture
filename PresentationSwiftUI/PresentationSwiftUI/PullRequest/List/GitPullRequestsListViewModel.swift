//
//  PullRequestsListViewModel.swift
//  PresentationSwiftUI
//
//  Created by Lucas Silveira on 22/04/20.
//  Copyright © 2020 blu. All rights reserved.
//

import DomainLayer
import UIKit

class GitPullRequestsListViewModel: ObservableObject {
    @Published var repository: GitRepositoryModel
    private var fetchPullRequestsUseCase: FetchPullRequestsUseCaseProtocol

    @Published var pullRequests: [GitPullRequestUIModel] = []
    @Published var error: String? = nil

    init(fetchPullRequestsUseCase: FetchPullRequestsUseCaseProtocol, gitRepository: GitRepositoryModel) {
        repository = gitRepository
        self.fetchPullRequestsUseCase = fetchPullRequestsUseCase
        self.fetchPullRequestsUseCase.delegateInterfaceAdapter = self
    }

    func fetch() {
        fetchPullRequestsUseCase.execute(repo: repository)
    }
}

extension GitPullRequestsListViewModel: FetchPullRequestsInterfaceAdapter {
    func doing() {
        //
    }

    func done(data: [GitPullRequestModel]) {
        pullRequests = data.map(GitPullRequestUIModel.init)
    }

    func failure(error: Error) {
        self.error = error.localizedDescription
    }
}
