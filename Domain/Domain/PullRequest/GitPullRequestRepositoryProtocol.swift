//
//  GitPullRequestRepositoryInterface.swift
//  Domain
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public protocol GitPullRequestRepositoryProtocol {
    func list(repo: GitRepositoryModel, completion: @escaping (Result<[GitPullRequestModel], Error>) -> Void)
    func commits(repoName: String, owner: String, completion: @escaping (Result<[GitCommitModel], Error>) -> Void)
    func get(id: Int, fromRepo repo: GitRepositoryModel, completion: @escaping (Result<GitPullRequestModel, Error>) -> Void)
}
