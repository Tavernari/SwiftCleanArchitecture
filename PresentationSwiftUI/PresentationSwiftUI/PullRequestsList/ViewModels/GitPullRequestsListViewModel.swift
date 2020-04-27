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

class GitPullRequestUIModel: Identifiable {
    var ghPullRequest: GitPullRequestModel

    init(ghPullRequest: GitPullRequestModel) {
        self.ghPullRequest = ghPullRequest
    }

    var number: Int {
        return ghPullRequest.id
    }

    var title: String {
        return ghPullRequest.title
    }

    var description: String {
        return ghPullRequest.description
    }

    var createdAt: String {
        return ghPullRequest.createdAt!.to_ddMMyyyy_HHmm()
    }

    var updatedAt: String {
        return ghPullRequest.updatedAt!.to_ddMMyyyy_HHmm()
    }

    var avatarURL: String {
        return ghPullRequest.image
    }
}
