//
//  UseCaseFacade.swift
//  PresentationSwiftUI
//
//  Created by Lucas Silveira on 22/04/20.
//  Copyright © 2020 blu. All rights reserved.
//

import DataLayer
import Domain

class UseCaseFacade {
    private init() {}

    static func fetchGitRepositoryUseCase(enableStats: Bool = true) -> FetchGitRepositoriesUseCaseProtocol {
        let gitRepoDataSource = GithubRepoDataSource()
        let gitRepoRemoteConfigDataSource = MemoryGitRepoRemoteConfigDataSource(enable: enableStats, multiplier: 4)
        let gitRepository = GitRepoRepository(gitRepoDataSource: gitRepoDataSource, remoteConfigDataSource: gitRepoRemoteConfigDataSource)

        let calculatorUseCase = ReliabilityRepoCalculator()

        return FetchGitRepositoriesUseCase(gitRepoRepository: gitRepository, reliabilityCalculatorUseCase: calculatorUseCase)
    }

    static func fetchPullRequestsUseCase() -> FetchPullRequestsUseCaseProtocol {
        let gitPullRequestDataSource = GithubPullRequestDataSource()
        let gitPullRepository = GitPullRequestDataRepository(dataSource: gitPullRequestDataSource)
        return FetchPullRequestsUseCase(repository: gitPullRepository)
    }
}
