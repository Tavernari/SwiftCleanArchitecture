//
//  MockGitPullRequestDataSource.swift
//  PresentationTests
//
//  Created by Victor C Tavernari on 08/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Domain
import DataSource

class MockGitPullRequestDataSource: GitPullRequestDataSource {

    private let result: Any
    init(result: Any){
       self.result = result
    }

    func list(repo: GitRepository, completion: @escaping (Result<[GitPullRequest], Error>) -> Void) {
        completion(.success(self.result as! [GitPullRequest]))
    }

    func get(id: Int, fromRepo repo: GitRepository, completion: @escaping (Result<GitPullRequest, Error>) -> Void) {
        completion(.success(self.result as! GitPullRequest))
    }
}
