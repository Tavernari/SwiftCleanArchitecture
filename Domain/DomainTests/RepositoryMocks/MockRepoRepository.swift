//
//  MockRepoRepository.swift
//  DomainTests
//
//  Created by Victor C Tavernari on 04/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation
import Domain

class MockRepoRepository: GitRepoRepository {
    func list(term: String, completion: @escaping (Result<[GitRepository], ListGitRepositoryUseCaseError>) -> Void) {

        guard error == nil else {
            completion(.failure(error!))
            return
        }

        completion(.success(result!))
    }


    private var result: [GitRepository]?
    private var error: ListGitRepositoryUseCaseError?
    init(result: [GitRepository]?, error: ListGitRepositoryUseCaseError?) {
        self.result = result
        self.error = error
    }

}
