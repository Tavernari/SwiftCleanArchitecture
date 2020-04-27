//
//  GitRepository+FromGithub.swift
//  DataSource
//
//  Created by Victor C Tavernari on 06/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import DomainLayer

extension GitRepositoryModel {
    init(data: GitbRepositoryData) {
        self.init()
        author = data.owner.login
        description = data.description ?? ""
        forkCount = data.forks_count
        image = data.owner.avatar_url
        issuesCount = data.open_issues_count
        name = data.name
        starCount = data.stargazers_count
    }

    static func retornaNovo() -> GitRepositoryModel {
        return GitRepositoryModel()
    }
}
