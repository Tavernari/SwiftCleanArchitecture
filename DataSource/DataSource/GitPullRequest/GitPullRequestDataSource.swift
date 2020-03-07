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
    func list(owner: String, onRepository repository: String) -> Observable<[GitPullRequest]>
}
