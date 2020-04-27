//
//  PullRequestsListViewModel.swift
//  PresentationSwiftUI
//
//  Created by Lucas Silveira on 22/04/20.
//  Copyright © 2020 blu. All rights reserved.
//

import Domain
import UIKit

class PullRequestsListViewModel: ObservableObject {
    @Published var repository: GitRepository
    private var useCase: FetchPullRequestsUseCaseProtocol

    @Published var pullRequests: [GHPullRequestsViewModel] = []
    @Published var error: String? = nil

    init(useCase: FetchPullRequestsUseCaseProtocol, gitRepository: GitRepository) {
        repository = gitRepository
        self.useCase = useCase
        self.useCase.delegateInterfaceAdapter = self
    }

    func fetch() {
        useCase.execute(repo: repository)
    }
}

extension PullRequestsListViewModel: FetchPullRequestsInterfaceAdapter {
    func doing() {
        //
    }

    func done(data: [GitPullRequest]) {
        pullRequests = data.map(GHPullRequestsViewModel.init)
    }

    func failure(error: Error) {
        self.error = error.localizedDescription
    }
}

class GHPullRequestsViewModel: Identifiable {
    var ghPullRequest: GitPullRequest

    init(ghPullRequest: GitPullRequest) {
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
        return ghPullRequest.createdAt!.ghDateFormat()
    }

    var updatedAt: String {
        return ghPullRequest.updatedAt!.ghDateFormat()
    }

    var avatarURL: String {
        return ghPullRequest.image
    }
}
