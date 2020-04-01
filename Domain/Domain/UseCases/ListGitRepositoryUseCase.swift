//
//  ListRepositories.swift
//  Domain
//
//  Created by Victor C Tavernari on 02/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public class HandleResult {
    public static func handle<T, E>(result: Result<T, E>) throws -> T where E: Error {
        switch result {
        case .failure(let error):
            throw error
        case .success(let data):
            return data
        }
    }
}

public enum ListGitRepositoryUseCaseError: Error {
    case failWhenFetchRepository(message: String?)
    case failWhenGetReliabilityMultiplier(message: String?)
}

public protocol ListGitRepositoryUseCase {
    func execute(term: String, completion: @escaping (Result<[GitRepository], ListGitRepositoryUseCaseError>) -> Void)
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

    public func execute(term: String, completion: @escaping (Result<[GitRepository], ListGitRepositoryUseCaseError>) -> Void) {
        let dispatchGroup = DispatchGroup()

        var repositories = [GitRepository]()
        var repoReliabilityMultiplierModel = GitRepoReliabilityMultiplier()
        var errorResult: ListGitRepositoryUseCaseError?

        dispatchGroup.enter()
        self.gitRepoRepository.list(term: term) { result in
            do { repositories = try HandleResult.handle(result: result) }
            catch let error as ListGitRepositoryUseCaseError { errorResult = error }
            catch { errorResult = .failWhenFetchRepository(message: nil) }
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        self.configRepository.gitRepoReliabilityMultiplier { result in
            do { repoReliabilityMultiplierModel = try HandleResult.handle(result: result) }
            catch let error as ListGitRepositoryUseCaseError { errorResult = error }
            catch { errorResult = .failWhenGetReliabilityMultiplier(message: nil) }
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
}
