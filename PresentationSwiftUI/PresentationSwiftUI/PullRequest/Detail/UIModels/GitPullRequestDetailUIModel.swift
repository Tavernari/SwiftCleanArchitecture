//
// Created by Victor C Tavernari on 29/04/20.
// Copyright (c) 2020 blu. All rights reserved.
//

import DomainLayer

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
