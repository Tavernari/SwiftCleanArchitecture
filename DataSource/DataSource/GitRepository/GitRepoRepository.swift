//
//  GitRepoRepository.swift
//  DataSource
//
//  Created by Victor C Tavernari on 06/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Alamofire
import Domain

public class GitRepoRepository: GitRepoRepositoryInterface {
    private let gitRepoDataSource: GitRepoDataSource
    public init(gitRepoDataSource: GitRepoDataSource) {
        self.gitRepoDataSource = gitRepoDataSource
    }

    public func list(term: String, completion: @escaping (Result<[GitRepository], Error>) -> Void) {
        let dispatchGroup = DispatchGroup()

        var gitRepoRepositoriesResult: [GitRepository] = []
        var error: Error?

        dispatchGroup.enter()
        gitRepoDataSource.list(term: term) { result in
            switch result {
            case let .success(repositories):
                repositories.forEach { repo in
                    var gitRepo = repo
                    dispatchGroup.enter()
                    self.gitRepoDataSource.stats(repo: repo) { result in
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

    public func stats(repo: GitRepository, completion: @escaping (Result<GitRepoStatsModel, Error>) -> Void) {
        gitRepoDataSource.stats(repo: repo, completion: completion)
    }
}
