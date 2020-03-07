//
//  GithubRepoRepository.swift
//  DataSource
//
//  Created by Victor C Tavernari on 06/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Domain
import RxSwift
import Alamofire

public class GithubRepoRepository: GitRepoRepository {

    public init() {} 

    public func list(term: String) -> Observable<[Repository]> {
        return Observable.create { (observer) -> Disposable in
            let request = AF.request(GithubAPIRouter.search(term: term))
            request.responseDecodable { (response: DataResponse<GithubResponseData, AFError>) in
                switch response.result {
                case .success(let repositories):
                    let result = repositories.items.map(Repository.fromGithub)
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
