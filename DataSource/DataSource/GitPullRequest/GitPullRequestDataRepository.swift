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

    public func list(owner: String, onRepository repository: String) -> Observable<[GitPullRequest]> {
        return self.dataSource.list(owner: owner, onRepository: repository)
    }
}
