//
//  GitPullRequest+FromGithub.swift
//  DataSource
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Domain

extension GitPullRequest {
    static func fromGithub(_ data: GithubPullRequestData) -> GitPullRequest {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        var pullRequest = GitPullRequest()
        pullRequest.id = data.number
        pullRequest.author = data.user.login
        pullRequest.description = data.body
        pullRequest.image = data.user.avatar_url
        pullRequest.title = data.title
        pullRequest.date = dateFormatter.date(from: data.created_at)
        return pullRequest
    }

    static func fromGithub(_ data: GithubPullRequestDetailData) -> GitPullRequest {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        var pullRequest = GitPullRequest()
        pullRequest.id = data.number
        pullRequest.author = data.user.login
        pullRequest.description = data.body
        pullRequest.image = data.user.avatar_url
        pullRequest.title = data.title
        pullRequest.date = dateFormatter.date(from: data.created_at)
        pullRequest.additionsCount = data.additions
        pullRequest.commentsCount = data.comments
        pullRequest.commitsCount = data.commits
        pullRequest.deletionsCount = data.deletions
        pullRequest.changedFilesCount = data.changed_files
        return pullRequest
    }
}
