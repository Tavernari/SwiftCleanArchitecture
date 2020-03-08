//
//  GetPullRequestDetailUseCase.swift
//  Domain
//
//  Created by Victor C Tavernari on 08/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public protocol GetPullRequestDetailUseCase {
    func execute(id: Int, fromRepo repo: GitRepository, completion: @escaping (Result<GitPullRequest, Error>) -> Void)
}

public class DoGetPullRequestDetailUseCase: GetPullRequestDetailUseCase {
    private let repository: GitPullRequestRepository

    public init(repository: GitPullRequestRepository) {
       self.repository = repository
    }

    public func execute(id: Int, fromRepo repo: GitRepository, completion: @escaping (Result<GitPullRequest, Error>) -> Void) {
        return self.repository.get(id: id, fromRepo: repo, completion: completion)
    }
}
