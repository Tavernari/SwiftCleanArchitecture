//
//  PullRequestShowViewModel.swift
//  PresentationSwiftUI
//
//  Created by Lucas Silveira on 23/04/20.
//  Copyright © 2020 blu. All rights reserved.
//

import DomainLayer
import Foundation

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
