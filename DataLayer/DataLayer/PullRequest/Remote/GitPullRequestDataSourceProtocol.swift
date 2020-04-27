//
//  GitPullRequestDataSource.swift
//  DataSource
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

// sourcery: AutoMockable
import Domain

public protocol GitPullRequestDataSourceProtocol {
    func list(repo: GitRepositoryModel, completion: @escaping (Result<[GitPullRequestData], Error>) -> Void)
    func commits(repoName: String, prOwner: String, completion: @escaping (Result<[GitPullRequestCommitsData], Error>) -> Void)
    func get(id: Int, fromRepo repo: GitRepositoryModel, completion: @escaping (Result<GitPullRequestDetailData, Error>) -> Void)
}
