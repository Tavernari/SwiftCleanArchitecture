//
//  GitPullRequestDataSource.swift
//  DataSource
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

//sourcery: AutoMockable
import Domain

public protocol GitPullRequestDataSource {
    func list(repo: GitRepository, completion: @escaping (Result<[GitPullRequest], Error>) -> Void)
    func get(id: Int, fromRepo repo: GitRepository, completion: @escaping (Result<GitPullRequest, Error>) -> Void)
}
