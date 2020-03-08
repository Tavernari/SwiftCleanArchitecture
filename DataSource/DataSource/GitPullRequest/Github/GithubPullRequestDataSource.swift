//
//  GithubPullRequestDataSource.swift
//  DataSource
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Domain
import RxSwift
import Alamofire

public class GithubPullRequestDataSource: GitPullRequestDataSource {

    public init() {}
    
    public func list(repo: GitRepository) -> Observable<[GitPullRequest]> {
        return Observable.create { (observer) -> Disposable in
            let request = AF.request(GithubAPIRouter.listPullRequest(owner: repo.author, repoName: repo.name))
            request.responseDecodable { (response: DataResponse<[GithubPullRequestData], AFError>) in
                switch response.result {
                case .success(let pullRequests):
                    let result = pullRequests.map(GitPullRequest.fromGithub)
                    observer.onNext(result)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }

            return Disposables.create {
                request.cancel()
            }
        }
    }

    public func get(id: Int, fromRepo repo: GitRepository) -> Observable<GitPullRequest> {
        return Observable.create { (observer) -> Disposable in
            let request = AF.request(GithubAPIRouter.getPullRequest(owner: repo.author, repoName: repo.name, pullNumber: id))
            request.responseDecodable { (response: DataResponse<GithubPullRequestDetailData, AFError>) in
                switch response.result {
                case .success(let pullRequest):
                    let result = GitPullRequest.fromGithub(pullRequest)
                    observer.onNext(result)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }

            return Disposables.create {
                request.cancel()
            }
        }
    }

}
