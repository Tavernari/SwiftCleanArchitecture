//
//  GitPullRequestRepository.swift
//  DataSource
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import DomainLayer

public class GitPullRequestRepository: GitPullRequestRepositoryProtocol {
    private let dataSource: GitPullRequestDataSourceProtocol
    public init(dataSource: GitPullRequestDataSourceProtocol) {
        self.dataSource = dataSource
    }

    public func list(repo: GitRepositoryModel, completion: @escaping (Result<[GitPullRequestModel], Error>) -> Void) {
        dataSource.list(repo: repo) { result in
            result.handle(decodeSuccess: { $0.map(GitPullRequestModel.init) }, completion: completion)
        }
    }

    public func get(
        id: Int,
        fromRepo repo: GitRepositoryModel,
        completion: @escaping (Result<GitPullRequestModel, Error>) -> Void
    ) {
        dataSource.get(id: id, fromRepo: repo) { result in
            result.handle(decodeSuccess: { GitPullRequestModel($0) }, completion: completion)
        }
    }

    public func commits(repoName: String, owner: String, completion: @escaping (Result<[GitCommitModel], Error>) -> Void) {
        dataSource.commits(repoName: repoName, prOwner: owner) { result in
            result.handle(decodeSuccess: { $0.map(GitCommitModel.init) }, completion: completion)
        }
    }
}
