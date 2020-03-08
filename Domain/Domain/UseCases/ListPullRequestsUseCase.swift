//
//  ListPullRequestsUseCase.swift
//  Domain
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public protocol ListPullRequestsUseCase {
    func execute(repo: GitRepository, completion: @escaping (Result<[GitPullRequest], Error>) -> Void)
}

public class DoListPullRequestsUseCase: ListPullRequestsUseCase {

    private let repository: GitPullRequestRepository

    public init(repository: GitPullRequestRepository) {
       self.repository = repository
    }

    public func execute(repo: GitRepository, completion: @escaping (Result<[GitPullRequest], Error>) -> Void) {
        return self.repository.list(repo: repo, completion: completion)
    }
}
