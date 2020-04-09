//
//  GitPullRequest+FromGithub.swift
//  DataSource
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Domain

extension GitPullRequest {
    init(_ data: GithubPullRequestData) {
        self.init()
        id = data.number
        author = data.user.login
        description = data.body
        image = data.user.avatar_url
        title = data.title
        date = data.created_at.toYYYY_MM_DD_T_HH_mm_SS_Z()
    }

    init(_ data: GithubPullRequestDetailData) {
        self.init()

        id = data.number
        author = data.user.login
        description = data.body
        image = data.user.avatar_url
        title = data.title
        date = data.created_at.toYYYY_MM_DD_T_HH_mm_SS_Z()
        additionsCount = data.additions
        commentsCount = data.comments
        commitsCount = data.commits
        deletionsCount = data.deletions
        changedFilesCount = data.changed_files
    }
}
