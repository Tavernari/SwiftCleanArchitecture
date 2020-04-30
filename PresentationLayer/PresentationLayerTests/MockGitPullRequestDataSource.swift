//
//  MockGitPullRequestDataSource.swift
//  PresentationTests
//
//  Created by Victor C Tavernari on 08/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import DataLayer
import DomainLayer

class MockGitPullRequestDataSource: GitPullRequestDataSourceProtocol {
    private let result: Any
    init(result: Any) {
        self.result = result
    }

    func list(repo _: GitRepositoryModel, completion: @escaping (Result<[GitPullRequestDTO], Error>) -> Void) {
        guard let result = self.result as? [GitPullRequestDTO] else {
            fatalError()
        }

        completion(.success(result))
    }

    func get(id _: Int, fromRepo _: GitRepositoryModel, completion: @escaping (Result<GitPullRequestDetailDTO, Error>) -> Void) {
        guard let result = self.result as? GitPullRequestDetailDTO else {
            fatalError()
        }

        completion(.success(result))
    }

    func commits(repoName _: String, prOwner _: String, completion: @escaping (Result<[GitPullRequestCommitsDTO], Error>) -> Void) {
        guard let result = self.result as? [GitPullRequestCommitsDTO] else {
            fatalError()
        }

        completion(.success(result))
    }
}
