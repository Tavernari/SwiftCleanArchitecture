//
// Created by Victor C Tavernari on 29/04/20.
// Copyright (c) 2020 blu. All rights reserved.
//

import DomainLayer

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
