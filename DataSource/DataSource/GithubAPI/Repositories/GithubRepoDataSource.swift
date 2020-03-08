//
//  GithubRepoDataSource.swift
//  DataSource
//
//  Created by Victor C Tavernari on 08/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Domain
import Alamofire

public class GithubRepoDataSource: GitRepoDataSource {

    public init() {}

    public func list(term: String, completion: @escaping (Result<[GitRepository], Error>) -> Void) {
            let request = AF.request(GithubAPIRouter.search(term: term))
            request.responseDecodable { (response: DataResponse<GithubResponseData, AFError>) in
                switch response.result {
                case .success(let repositories):
                    let result = repositories.items.map(GitRepository.fromGithub)
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
