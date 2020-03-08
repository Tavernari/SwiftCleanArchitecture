//
//  MockGitPullRequestDataSource.swift
//  PresentationTests
//
//  Created by Victor C Tavernari on 08/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Domain
import DataSource
import RxSwift

class MockGitPullRequestDataSource: GitPullRequestDataSource {

    private let result: Observable<Any>
    init(result: Observable<Any>){
       self.result = result
    }

    func list(repo: GitRepository) -> Observable<[GitPullRequest]> {
        return result.map { $0 as! [GitPullRequest]}
    }

    func get(id: Int, fromRepo repo: GitRepository) -> Observable<GitPullRequest> {
        return result.map { $0 as! GitPullRequest}
    }
}
