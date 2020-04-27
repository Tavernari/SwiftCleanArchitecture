//
//  GitRepoRepository.swift
//  DataSource
//
//  Created by Victor C Tavernari on 06/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Alamofire
import Domain

public class GitRepoRepository: GitRepoRepositoryProtocol {
    private let gitRepoDataSource: GitRepoDataSourceProtocol
    private let remoteConfigDataSource: GitRepoRemoteConfigDataSourceProtocol
    public init(gitRepoDataSource: GitRepoDataSourceProtocol, remoteConfigDataSource: GitRepoRemoteConfigDataSourceProtocol) {
        self.gitRepoDataSource = gitRepoDataSource
        self.remoteConfigDataSource = remoteConfigDataSource
    }

    public func list(term: String, completion: @escaping (Result<[GitRepositoryModel], Error>) -> Void) {
        let dispatchGroup = DispatchGroup()

        var gitRepoRepositoriesResult: [GitRepositoryModel] = []
        var error: Error?

        dispatchGroup.enter()
        gitRepoDataSource.list(term: term) { result in
            switch result {
            case let .success(data):
                data.items.forEach { repo in
                    var gitRepo = GitRepositoryModel(data: repo)
                    dispatchGroup.enter()
                    self.gitRepoDataSource.stats(repo: gitRepo) { result in
                        switch result {
                        case let .success(model):
                            gitRepo.stats = model
                            gitRepoRepositoriesResult.append(gitRepo)
                        case let .failure(statsError):
                            error = statsError
                        }
                        dispatchGroup.leave()
                    }
                }
            case let .failure(dataSourceError):
                error = dataSourceError
            }
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .global(qos: .background)) {
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(error!))
                }
                return
            }

            DispatchQueue.main.async {
                completion(.success(gitRepoRepositoriesResult))
            }
        }
    }

    public func stats(repo: GitRepositoryModel, completion: @escaping (Result<GitRepoStatsModel, Error>) -> Void) {
        gitRepoDataSource.stats(repo: repo, completion: completion)
    }

    public func getRepoReliabilityMultiplier(
        completion: @escaping (Result<GitRepoReliabilityMultiplierModel, Error>
        ) -> Void) {
        remoteConfigDataSource.gitRepoReliabilityMultiplier(completion: completion)
    }
}
