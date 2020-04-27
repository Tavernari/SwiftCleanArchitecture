//
//  GitRepoDataSource.swift
//  DataSource
//
//  Created by Victor C Tavernari on 08/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Domain

// sourcery: AutoMockable
public protocol GitRepoDataSourceProtocol {
    func list(term: String, completion: @escaping (Result<GitReposResponseData, Error>) -> Void)
    func stats(repo: GitRepositoryModel, completion: @escaping (Result<GitRepoStatsModel, Error>) -> Void)
}
