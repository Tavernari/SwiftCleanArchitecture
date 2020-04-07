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
        let request = AF.request(GithubAPIRouter.listPullRequest(owner: repo.author, repoName: repo.name))
        request.responseDecodable { (response: DataResponse<[GithubPullRequestData], AFError>) in
            switch response.result {
            case let .success(pullRequests):
                let result = pullRequests.map(GitPullRequest.fromGithub)
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
        let route = GithubAPIRouter.getPullRequest(owner: repo.author, repoName: repo.name, pullNumber: id)
        let request = AF.request(route)
        request.responseDecodable { (response: DataResponse<GithubPullRequestDetailData, AFError>) in
            switch response.result {
            case let .success(pullRequest):
                let result = GitPullRequest.fromGithub(pullRequest)
                completion(.success(result))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
