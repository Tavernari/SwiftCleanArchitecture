//
//  GitPullRequestCommitsDataSource.swift
//  DataLayer
//
//  Created by Lucas Silveira on 23/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Alamofire
import Foundation

public protocol GitPullRequestCommitsDataSource {
    func list(repoName: String, ownerName: String, completion: @escaping (Result<[GithubPullRequestCommitsData], Error>) -> Void)
}

public class GithubPullRequestCommitsDataSource: GitPullRequestCommitsDataSource {
    public func list(repoName: String, ownerName: String, completion: @escaping (Result<[GithubPullRequestCommitsData], Error>) -> Void) {
        GithubPullRequestCommitsAPIRouter.listPullRequestCommits(owner: ownerName, repoName: repoName).request().processResponse(completion: completion)
    }

    public init() {}
}
