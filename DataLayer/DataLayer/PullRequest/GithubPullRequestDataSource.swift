//
//  GithubPullRequestDataSource.swift
//  DataSource
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Alamofire
import Domain

public class GithubPullRequestDataSource: GitPullRequestDataSource {
    public init() {}

    public func list(repo: GitRepository, completion: @escaping (Result<[GitPullRequest], Error>) -> Void) {
        GithubAPIRouter
            .listPullRequest(owner: repo.author, repoName: repo.name)
            .request(decodeError: { GithubAPIError.make(data: $0) })
            .responseDecodable { (response: DataResponse<[GithubPullRequestData], AFError>) in
                switch response.result {
                case let .success(pullRequests):
                    let result = pullRequests.map(GitPullRequest.init)
                    completion(.success(result))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
    }

    public func get(
        id: Int,
        fromRepo repo: GitRepository,
        completion: @escaping (Result<GitPullRequest, Error>) -> Void
    ) {
        GithubAPIRouter
            .getPullRequest(owner: repo.author, repoName: repo.name, pullNumber: id)
            .request(decodeError: { GithubAPIError.make(data: $0) })
            .responseDecodable { (response: DataResponse<GithubPullRequestDetailData, AFError>) in
                switch response.result {
                case let .success(pullRequest):
                    let result = GitPullRequest(pullRequest)
                    completion(.success(result))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
    }
}
