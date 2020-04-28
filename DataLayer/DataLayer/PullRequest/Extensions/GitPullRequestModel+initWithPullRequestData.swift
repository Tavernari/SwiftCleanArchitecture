//
//  GitPullRequest+FromGithub.swift
//  DataSource
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import DomainLayer

extension GitPullRequestModel {
    init(_ data: GitPullRequestData) {
        self.init()
        id = data.number
        author = data.user.login
        description = data.body
        image = data.user.avatar_url
        title = data.title
        createdAt = data.created_at.toYYYY_MM_DD_T_HH_mm_SS_Z()
        updatedAt = data.updated_at.toYYYY_MM_DD_T_HH_mm_SS_Z()
    }

    init(_ data: GitPullRequestDetailData) {
        self.init()

        id = data.number
        author = data.user.login
        description = data.body
        image = data.user.avatar_url
        title = data.title
        createdAt = data.created_at.toYYYY_MM_DD_T_HH_mm_SS_Z()
        updatedAt = data.updated_at.toYYYY_MM_DD_T_HH_mm_SS_Z()
        additionsCount = data.additions
        commentsCount = data.comments
        commitsCount = data.commits
        deletionsCount = data.deletions
        changedFilesCount = data.changed_files
    }
}
