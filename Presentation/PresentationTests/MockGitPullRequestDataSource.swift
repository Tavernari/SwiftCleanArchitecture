//
//  MockGitPullRequestDataSource.swift
//  PresentationTests
//
//  Created by Victor C Tavernari on 08/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import DataLayer
import Domain

class MockGitPullRequestDataSource: GitPullRequestDataSourceProtocol {
    private let result: Any
    init(result: Any) {
        self.result = result
    }

    func list(repo _: GitRepositoryModel, completion: @escaping (Result<[GitPullRequestData], Error>) -> Void) {
        guard let result = self.result as? [GitPullRequestData] else {
            fatalError()
        }

        completion(.success(result))
    }

    func get(id _: Int, fromRepo _: GitRepositoryModel, completion: @escaping (Result<GitPullRequestDetailData, Error>) -> Void) {
        guard let result = self.result as? GitPullRequestDetailData else {
            fatalError()
        }

        completion(.success(result))
    }
}
