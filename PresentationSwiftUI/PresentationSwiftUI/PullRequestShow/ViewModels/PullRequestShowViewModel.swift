//
//  PullRequestShowViewModel.swift
//  PresentationSwiftUI
//
//  Created by Lucas Silveira on 23/04/20.
//  Copyright © 2020 blu. All rights reserved.
//

import Domain
import Foundation

class GHCommitsViewModel: Identifiable {
    let id = UUID()
    var ghCommit: GitCommitModel

    init(ghCommit: GitCommitModel) {
        self.ghCommit = ghCommit
    }

    var author: String {
        return ghCommit.name
    }

    var message: String {
        return ghCommit.message
    }

    var sha: String {
        return ghCommit.sha
    }
}

class GHPullRequestShowUIModel: Identifiable {
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

    var comments: Int {
        return ghPullRequest.commitsCount
    }

    var commits: Int {
        return ghPullRequest.commitsCount
    }

    var additions: Int {
        return ghPullRequest.additionsCount
    }

    var deletions: Int {
        return ghPullRequest.deletionsCount
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

class PullRequestShowViewModel: ObservableObject {
    private var prUseCase: FetchPullRequestDetailUseCaseProtocol
    private var commitsUseCase: FetchPullRequestCommitsUseCaseProtocol

    var repo: GitRepositoryModel
    @Published var prName: String? = ""
    @Published var pullRequest: GHPullRequestShowUIModel? = nil
    @Published var commits: [GHCommitsViewModel] = []
    @Published var error: String? = nil

    init(prUseCase: FetchPullRequestDetailUseCaseProtocol, commitsUseCase: FetchPullRequestCommitsUseCaseProtocol, repo: GitRepositoryModel, prID: Int, prName: String, repoName: String, ownerName: String) {
        self.prUseCase = prUseCase
        self.commitsUseCase = commitsUseCase

        self.repo = repo
        self.prName = prName

        self.prUseCase.delegateInterfaceAdapter = self
        self.commitsUseCase.delegateInterfaceAdapter = self

        self.prUseCase.execute(id: prID, fromRepo: repo)
        self.commitsUseCase.execute(repoName: repoName, ownerName: ownerName)
    }
}

extension PullRequestShowViewModel: FetchPullRequestDetailInterfaceAdapter, FetchPullRequestCommitsInterfaceAdapter {
    func doing() {
        //
    }

    func done(data: GitPullRequestModel) {
        pullRequest = .init(ghPullRequest: data)
    }

    func done(data: [GitCommitModel]) {
        commits = data.map(GHCommitsViewModel.init)
    }

    func failure(error: Error) {
        self.error = error.localizedDescription
    }
}
