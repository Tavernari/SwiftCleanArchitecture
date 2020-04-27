//
//  GitPullRequestRepository.swift
//  DataSource
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Domain

public class GitPullRequestRepository: GitPullRequestRepositoryProtocol {
    private let dataSource: GitPullRequestDataSourceProtocol
    public init(dataSource: GitPullRequestDataSourceProtocol) {
        self.dataSource = dataSource
    }

    public func list(repo: GitRepository, completion: @escaping (Result<[GitPullRequest], Error>) -> Void) {
        dataSource.list(repo: repo) { result in
            result.handle(decodeSuccess: { $0.map(GitPullRequest.init) }, completion: completion)
        }
    }

    public func get(
        id: Int,
        fromRepo repo: GitRepository,
        completion: @escaping (Result<GitPullRequest, Error>) -> Void
    ) {
        dataSource.get(id: id, fromRepo: repo) { result in
            result.handle(decodeSuccess: { GitPullRequest($0) }, completion: completion)
        }
    }
}
