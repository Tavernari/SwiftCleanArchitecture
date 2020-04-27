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

    func list(repo _: GitRepository, completion: @escaping (Result<[GithubPullRequestData], Error>) -> Void) {
        guard let result = self.result as? [GithubPullRequestData] else {
            fatalError()
        }

        completion(.success(result))
    }

    func get(id _: Int, fromRepo _: GitRepository, completion: @escaping (Result<GithubPullRequestDetailData, Error>) -> Void) {
        guard let result = self.result as? GithubPullRequestDetailData else {
            fatalError()
        }

        completion(.success(result))
    }
}
