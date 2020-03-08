//
//  GetPullRequestDetailUseCase.swift
//  Domain
//
//  Created by Victor C Tavernari on 08/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import RxSwift

public protocol GetPullRequestDetailUseCase {
    func execute(id: Int, fromRepo repo: GitRepository) -> Observable<GitPullRequest>
}

public class DoGetPullRequestDetailUseCase: GetPullRequestDetailUseCase {
    private let repository: GitPullRequestRepository

    public init(repository: GitPullRequestRepository) {
       self.repository = repository
    }

    public func execute(id: Int, fromRepo repo: GitRepository) -> Observable<GitPullRequest> {
        return self.repository.get(id: id, fromRepo: repo)
    }
}
