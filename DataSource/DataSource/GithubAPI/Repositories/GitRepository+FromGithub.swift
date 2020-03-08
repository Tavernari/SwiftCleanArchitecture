//
//  GitRepository+FromGithub.swift
//  DataSource
//
//  Created by Victor C Tavernari on 06/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Domain

extension GitRepository {
    static func fromGithub(_ data: GithubRepositoryData) -> GitRepository {
        var repository = GitRepository()
        repository.author = data.owner.login
        repository.description = data.description ?? ""
        repository.forkCount = data.forks_count
        repository.image = data.owner.avatar_url
        repository.issuesCount = data.open_issues_count
        repository.name = data.name
        repository.starCount = data.stargazers_count
        return repository
    }
}
