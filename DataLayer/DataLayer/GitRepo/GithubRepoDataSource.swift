//
//  GithubRepoDataSource.swift
//  DataSource
//
//  Created by Victor C Tavernari on 08/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Alamofire
import Domain

public class GithubRepoDataSource: GitRepoDataSource {
    public init() {}

    public func list(term: String, completion: @escaping (Result<[GithubRepositoryData], Error>) -> Void) {
        GithubRepoAPIRouter.search(term: term)
            .request(decodeError: { GithubAPIErrorData.decode(from: $0)?.message })
            .responseDecodable { (response: DataResponse<GithubResponseData, AFError>) in
                switch response.result {
                case let .success(repositories):
                    completion(.success(repositories.items))
                case let .failure(error):
                    if let underlyingError = error.underlyingError {
                        completion(.failure(underlyingError))
                    } else {
                        completion(.failure(error))
                    }
                }
            }
    }

    public func stats(repo: GitRepository, completion: @escaping (Result<GitRepoStatsModel, Error>) -> Void) {
        var gitRepoStatsModel = GitRepoStatsModel()
        gitRepoStatsModel.name = repo.name
        gitRepoStatsModel.closedIssues = Int.random(in: 0 ... 1000)
        gitRepoStatsModel.openedIssues = Int.random(in: 0 ... 1000)
        gitRepoStatsModel.mergedPullRequests = Int.random(in: 0 ... 1000)
        gitRepoStatsModel.proposedPullRequests = Int.random(in: 0 ... 1000)
        completion(.success(gitRepoStatsModel))
    }
}
