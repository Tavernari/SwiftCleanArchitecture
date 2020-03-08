//
//  GitPullRequestDataRepository.swift
//  DataSource
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Domain
import RxSwift

public class GitPullRequestDataRepository: GitPullRequestRepository {

    private let dataSource: GitPullRequestDataSource
    public init(dataSource: GitPullRequestDataSource) {
        self.dataSource = dataSource
    }

    public func list(repo: GitRepository, completion: @escaping (Result<[GitPullRequest], Error>) -> Void) {
        self.dataSource.list(repo: repo).subscribe(onNext: {
            completion(.success($0))
        })
    }

    public func get(id: Int, fromRepo repo: GitRepository, completion: @escaping (Result<GitPullRequest, Error>) -> Void) {
        self.dataSource.get(id: id, fromRepo: repo).subscribe(onNext: {
            completion(.success($0))
        })
    }

}
