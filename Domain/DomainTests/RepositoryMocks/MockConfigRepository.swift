//
//  MockConfigRepository.swift
//  DomainTests
//
//  Created by Victor C Tavernari on 31/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Domain

class MockConfigRepository: ConfigRepository {

    let enable: Bool
    let error: ListGitRepositoryUseCaseError?
    init(enable: Bool, error: ListGitRepositoryUseCaseError?){
        self.enable = enable
        self.error = error
    }

    func gitRepoReliabilityMultiplier(completion: @escaping (Result<GitRepoReliabilityMultiplier, ListGitRepositoryUseCaseError>) -> Void) {
        guard error == nil else {
            completion(.failure(error!))
            return
        }

        var model = GitRepoReliabilityMultiplier()
        model.enable = self.enable
        model.multiplier = 1
        completion(.success(model))
    }
}
