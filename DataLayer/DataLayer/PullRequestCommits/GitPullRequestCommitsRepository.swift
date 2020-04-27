//
//  GitPullRequestCommitsRepository.swift
//  DataLayer
//
//  Created by Lucas Silveira on 23/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Domain

public class GitPullRequestCommitsRepository: GitPullRequestCommitsRepositoryProtocol {
    private let dataSource: GitPullRequestCommitsDataSource
    public init(dataSource: GitPullRequestCommitsDataSource) {
        self.dataSource = dataSource
    }

    public func list(repoName: String, prOwner: String, completion: @escaping (Result<[GitCommit], Error>) -> Void) {
        dataSource.list(repoName: repoName, ownerName: prOwner) { result in
            result.handle(decodeSuccess: { $0.map(GitCommit.init) }, completion: completion)
        }
    }
}
