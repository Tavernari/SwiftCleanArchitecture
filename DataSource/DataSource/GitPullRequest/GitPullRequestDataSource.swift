//
//  GitPullRequestDataSource.swift
//  DataSource
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import RxSwift
import Domain

public protocol GitPullRequestDataSource {
    func list(repo: GitRepository) -> Observable<[GitPullRequest]>
    func get(id: Int, fromRepo repo:GitRepository) -> Observable<GitPullRequest>
}
