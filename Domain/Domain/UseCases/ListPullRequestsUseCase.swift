//
//  ListPullRequestsUseCase.swift
//  Domain
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import RxSwift

public protocol ListPullRequestsUseCase {
    func execute(repo: GitRepository) -> Observable<[GitPullRequest]>
}

public class DoListPullRequestsUseCase: ListPullRequestsUseCase {

    private let repository: GitPullRequestRepository

    public init(repository: GitPullRequestRepository) {
       self.repository = repository
    }

    public func execute(repo: GitRepository) -> Observable<[GitPullRequest]> {
        return self.repository.list(owner: repo.author, onRepository: repo.name)
    }
}
