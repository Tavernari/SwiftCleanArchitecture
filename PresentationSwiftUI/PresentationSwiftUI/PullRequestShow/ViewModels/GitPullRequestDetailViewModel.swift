//
//  PullRequestShowViewModel.swift
//  PresentationSwiftUI
//
//  Created by Lucas Silveira on 23/04/20.
//  Copyright © 2020 blu. All rights reserved.
//

import Domain
import Foundation

class GitCommitsUIModel: Identifiable {
    let id = UUID()
    var gitCommit: GitCommitModel

    init(gitCommit: GitCommitModel) {
        self.gitCommit = gitCommit
    }

    var author: String {
        return gitCommit.name
    }

    var message: String {
        return gitCommit.message
    }

    var sha: String {
        return gitCommit.sha
    }
}

class GitPullRequestDetailUIModel: Identifiable {
    var gitPullRequest: GitPullRequestModel

    init(gitPullRequest: GitPullRequestModel) {
        self.gitPullRequest = gitPullRequest
    }

    var number: Int {
        return gitPullRequest.id
    }

    var title: String {
        return gitPullRequest.title
    }

    var description: String {
        return gitPullRequest.description
    }

    var comments: Int {
        return gitPullRequest.commitsCount
    }

    var commits: Int {
        return gitPullRequest.commitsCount
    }

    var additions: Int {
        return gitPullRequest.additionsCount
    }

    var deletions: Int {
        return gitPullRequest.deletionsCount
    }

    var createdAt: String {
        return gitPullRequest.createdAt!.to_ddMMyyyy_HHmm()
    }

    var updatedAt: String {
        return gitPullRequest.updatedAt!.to_ddMMyyyy_HHmm()
    }

    var avatarURL: String {
        return gitPullRequest.image
    }
}

class GitPullRequestDetailViewModel: ObservableObject {
    private var fetchPullRequestDetailUseCase: FetchPullRequestDetailUseCaseProtocol
    private var fetchPullRequestCommitsUseCase: FetchPullRequestCommitsUseCaseProtocol

    var repo: GitRepositoryModel
    @Published var pullRequestName: String? = ""
    @Published var pullRequest: GitPullRequestDetailUIModel? = nil
    @Published var commits: [GitCommitsUIModel] = []
    @Published var error: String? = nil

    init(fetchPullRequestDetailUseCase: FetchPullRequestDetailUseCaseProtocol,
         fetchPullRequestCommitsUseCase: FetchPullRequestCommitsUseCaseProtocol,
         repo: GitRepositoryModel,
         pullRequestId: Int,
         pullRequestName: String,
         repoName: String,
         ownerName: String) {
        self.fetchPullRequestDetailUseCase = fetchPullRequestDetailUseCase
        self.fetchPullRequestCommitsUseCase = fetchPullRequestCommitsUseCase

        self.repo = repo
        self.pullRequestName = pullRequestName

        self.fetchPullRequestDetailUseCase.delegateInterfaceAdapter = self
        self.fetchPullRequestCommitsUseCase.delegateInterfaceAdapter = self

        self.fetchPullRequestDetailUseCase.execute(id: pullRequestId, fromRepo: repo)
        self.fetchPullRequestCommitsUseCase.execute(repoName: repoName, ownerName: ownerName)
    }
}

extension GitPullRequestDetailViewModel: FetchPullRequestDetailInterfaceAdapter, FetchPullRequestCommitsInterfaceAdapter {
    func doing() {
        //
    }

    func done(data: GitPullRequestModel) {
        pullRequest = .init(gitPullRequest: data)
    }

    func done(data: [GitCommitModel]) {
        commits = data.map(GitCommitsUIModel.init)
    }

    func failure(error: Error) {
        self.error = error.localizedDescription
    }
}
