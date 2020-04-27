//
//  GitPullRequestCommits+initWithCommitsData.swift
//  DataLayer
//
//  Created by Lucas Silveira on 23/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Domain

extension GitCommit {
    init(data: GitPullRequestCommitsData) {
        self.init()
        sha = data.sha
        name = data.commit.author.name
        email = data.commit.author.email
        date = data.commit.author.date.toYYYY_MM_DD_T_HH_mm_SS_Z()
        message = data.commit.message
    }
}
