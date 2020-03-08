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
    
    public func list(owner: String, onRepository repository: String) -> Observable<[GitPullRequest]> {
        return Observable.create { (observer) -> Disposable in
            let request = AF.request(GithubAPIRouter.listPullRequest(owner: owner, repoName: repository))
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
}
