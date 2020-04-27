//
//  GitRepoDataSource.swift
//  DataSource
//
//  Created by Victor C Tavernari on 08/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Domain

public class GitRepoDataSource: GitRepoDataSourceProtocol {
    public init() {}

    public func list(term: String, completion: @escaping (Result<GithubResponseData, Error>) -> Void) {
        GithubRepoAPIRouter.search(term: term)
            .request(decodeError: { GithubAPIError.make(data: $0) })
            .processResponse(completion: completion)
    }

    public func stats(repo: GitRepository, completion: @escaping (Result<GitRepoStatsModel, Error>) -> Void) {
        var gitRepoStatsModel = GitRepoStatsModel()
        gitRepoStatsModel.name = repo.name
        gitRepoStatsModel.closedIssues = Int.random(in: 0 ... 1000)
        gitRepoStatsModel.openedIssues = Int.random(in: 0 ... 1000)
        gitRepoStatsModel.mergedPullRequests = Int.random(in: 0 ... 1000)
        gitRepoStatsModel.proposedPullRequests = Int.random(in: 0 ... 1000)
        completion(.success(gitRepoStatsModel))
    }
}
