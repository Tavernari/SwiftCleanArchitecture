//
//  GitRepoRepository.swift
//  DataSource
//
//  Created by Victor C Tavernari on 06/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Domain
import Alamofire

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
        self.gitRepoDataSource.list(term: term) { result in
            switch result {
            case .success(let repositories):
                repositories.forEach { repo in
                    var gitRepo = repo
                    dispatchGroup.enter()
                    self.gitRepoDataSource.stats(repo: repo) { result in
                        switch result {
                        case .success(let model):
                            gitRepo.stats = model
                            gitRepoRepositoriesResult.append(gitRepo)
                        case .failure(let statsError):
                            error = statsError
                        }
                        dispatchGroup.leave()
                    }
                }
            case .failure(let dataSourceError):
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
        self.gitRepoDataSource.stats(repo: repo, completion: completion)
    }
}
