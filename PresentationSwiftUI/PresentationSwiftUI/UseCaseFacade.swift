//
//  UseCaseFacade.swift
//  PresentationSwiftUI
//
//  Created by Lucas Silveira on 22/04/20.
//  Copyright © 2020 blu. All rights reserved.
//

import DataLayer
import Domain
import Foundation

class UseCaseFacade {
    private init() {}

    static func fetchGitRepositoryUseCase(enableStats: Bool = true) -> FetchGitRepositoriesUseCaseProtocol {
        let gitRepoDataSource = GithubRepoDataSource()
        let gitRepoRemoteConfigDataSource = MemoryGitRepoRemoteConfigDataSource(enable: enableStats, multiplier: 4)
        let gitRepository = GitRepoRepository(gitRepoDataSource: gitRepoDataSource, remoteConfigDataSource: gitRepoRemoteConfigDataSource)

        let calculatorUseCase = ReliabilityRepoCalculator()

        return FetchGitRepositoriesUseCase(gitRepoRepository: gitRepository, reliabilityCalculatorUseCase: calculatorUseCase)
    }
}
