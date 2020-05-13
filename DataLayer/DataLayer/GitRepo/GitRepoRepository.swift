//
//  GitRepoRepository.swift
//  DataSource
//
//  Created by Victor C Tavernari on 06/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Alamofire
import DomainLayer

public class GitRepoRepository: GitRepoRepositoryProtocol {
    private let gitRepoDataSource: GitRepoDataSourceProtocol
    private let remoteConfigDataSource: GitRepoRemoteConfigDataSourceProtocol
    public init(gitRepoDataSource: GitRepoDataSourceProtocol, remoteConfigDataSource: GitRepoRemoteConfigDataSourceProtocol) {
        self.gitRepoDataSource = gitRepoDataSource
        self.remoteConfigDataSource = remoteConfigDataSource
    }

    private func fetchAndSetStats(gitRepo: GitRepositoryModel, completion: @escaping (Result<GitRepositoryModel, Error>) -> Void) {
        gitRepoDataSource.stats(repo: gitRepo) { result in
            var repo = gitRepo
            result.handle(decodeSuccess: { (stats) -> GitRepositoryModel in
                repo.stats = stats
                return repo
            }, completion: completion)
        }
    }

    public func list(term: String, completion: @escaping (Result<[GitRepositoryModel], Error>) -> Void) {
        let dispatchGroup = DispatchGroup()
        var gitRepoRepositoriesResult: [GitRepositoryModel] = []
        dispatchGroup.enter()
        gitRepoDataSource.list(term: term) { result in
            do {
                let data = try result.handle()
                let repos = data.items.map(GitRepositoryModel.init)
                repos.forEach { repo in
                    dispatchGroup.enter()
                    self.fetchAndSetStats(gitRepo: repo) { result in
                        let repoWithStats = try? result.handle()
                        gitRepoRepositoriesResult.append(repoWithStats!)
                        dispatchGroup.leave()
                    }
                }
            } catch let statsError {
                DispatchQueue.main.async { completion(.failure(statsError)) }
            }
        }
        dispatchGroup.leave()
        dispatchGroup.notify(queue: .global(qos: .background)) {
            DispatchQueue.main.async { completion(.success(gitRepoRepositoriesResult)) }
        }
    }

    public func stats(repo: GitRepositoryModel, completion: @escaping (Result<GitRepoStatsModel, Error>) -> Void) {
        gitRepoDataSource.stats(repo: repo, completion: completion)
    }

    public func getRepoReliabilityMultiplier(completion: @escaping (Result<GitRepoReliabilityMultiplierModel, Error>) -> Void) {
        remoteConfigDataSource.gitRepoReliability { result in
            result.handle(decodeSuccess: { GitRepoReliabilityMultiplierModel(remoteConfigData: $0) }, completion: completion)
        }
    }
}
