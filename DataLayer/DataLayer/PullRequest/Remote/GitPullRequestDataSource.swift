//
//  GitPullRequestDataSource.swift
//  DataSource
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import DomainLayer

public class GitPullRequestDataSource: GitPullRequestDataSourceProtocol {
    public init() {}

    public func list(repo: GitRepositoryModel, completion: @escaping (Result<[GitPullRequestData], Error>) -> Void) {
        GithubAPIRouter
            .listPullRequest(owner: repo.author, repoName: repo.name)
            .request(decodeError: { GithubAPIError.make(data: $0) })
            .processResponse(completion: completion)
    }

    public func get(
        id: Int,
        fromRepo repo: GitRepositoryModel,
        completion: @escaping (Result<GitPullRequestDetailData, Error>) -> Void
    ) {
        GithubAPIRouter
            .getPullRequest(owner: repo.author, repoName: repo.name, pullNumber: id)
            .request(decodeError: { GithubAPIError.make(data: $0) })
            .processResponse(completion: completion)
    }

    public func commits(repoName: String, prOwner: String, completion: @escaping (Result<[GitPullRequestCommitsData], Error>) -> Void) {
        GithubAPIRouter
            .commits(owner: prOwner, repoName: repoName)
            .request()
            .processResponse(completion: completion)
    }
}
