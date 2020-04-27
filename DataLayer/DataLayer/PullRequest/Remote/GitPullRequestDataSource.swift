//
//  GitPullRequestDataSource.swift
//  DataSource
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Domain

public class GitPullRequestDataSource: GitPullRequestDataSourceProtocol {
    public init() {}

    public func list(repo: GitRepository, completion: @escaping (Result<[GithubPullRequestData], Error>) -> Void) {
        GithubAPIRouter
            .listPullRequest(owner: repo.author, repoName: repo.name)
            .request(decodeError: { GithubAPIError.make(data: $0) })
            .processResponse(completion: completion)
    }

    public func get(
        id: Int,
        fromRepo repo: GitRepository,
        completion: @escaping (Result<GithubPullRequestDetailData, Error>) -> Void
    ) {
        GithubAPIRouter
            .getPullRequest(owner: repo.author, repoName: repo.name, pullNumber: id)
            .request(decodeError: { GithubAPIError.make(data: $0) })
            .processResponse(completion: completion)
    }
}
