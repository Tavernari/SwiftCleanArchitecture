//
//  ListRepositories.swift
//  Domain
//
//  Created by Victor C Tavernari on 02/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public protocol ListGitRepositoryUseCase {
    func execute(term: String, completion: @escaping (Result<[GitRepository],Error>) -> Void)
}

public class DoListGitRepositoryUseCase: ListGitRepositoryUseCase {
    private let gitRepoRepository: GitRepoRepository
    private let configRepository: ConfigRepository
    private let reliabilityCalculatorRepository: ReliabilityMultiplierCalculatorRepository

    public init(gitRepoRepository: GitRepoRepository, configRepository: ConfigRepository, reliabilityCalculatorRepository: ReliabilityMultiplierCalculatorRepository) {
        self.gitRepoRepository = gitRepoRepository
        self.configRepository = configRepository
        self.reliabilityCalculatorRepository = reliabilityCalculatorRepository
    }

    public func execute(term: String, completion: @escaping (Result<[GitRepository],Error>) -> Void) {
        let dispatchGroup = DispatchGroup()

        var repositories = [GitRepository]()
        var repoReliabilityMultiplierModel = GitRepoReliabilityMultiplierModel()
        var errorResult: Error?

        dispatchGroup.enter()
        self.gitRepoRepository.list(term: term) { result in
            switch result {
            case .success(let repositoriesResult):
                repositories = repositoriesResult
            case .failure(let error):
                errorResult = error
            }

            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        self.configRepository.gitRepoReliabilityMultiplier { result in
            switch result {
            case .failure(let error):
                errorResult = error
            case .success(let model):
                repoReliabilityMultiplierModel = model
            }
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .global(qos: .background)) {

            guard errorResult == nil else{
                DispatchQueue.main.async {
                    completion(.failure(errorResult!))
                }
                return
            }

            let repoResult = repositories.map { repo -> GitRepository in
                var tempRepo = repo
                tempRepo.isReliabilityEnabled = repoReliabilityMultiplierModel.enable
                tempRepo.reliabilityScore = self.reliabilityCalculatorRepository.calculate(repoStats: repo.stats, multiplier: repoReliabilityMultiplierModel.multiplier)
                return tempRepo
            }

            DispatchQueue.main.async {
                completion(.success(repoResult))
            }
        }
    }

    internal func teste(a: String) -> String {
        return a
    }
}
