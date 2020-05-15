//
//  ListGitRepositoryUseCaseTests.swift
//  DomainTests
//
//  Created by Victor C Tavernari on 04/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

@testable import DomainLayer
import SwiftyMocky
import XCTest

class ListGitRepositoryUseCaseTests: XCTestCase {
    fileprivate func perfomExecuteList(_ repository: GitRepoRepositoryProtocolMock) {
        repository.perform(.list(term: .any, completion: .any, perform: { _, completion in
            completion(.success([GitRepositoryModel()]))
        }))
    }

    fileprivate func performExecuteGetRepoReliabilityMultiplier(_ repository: GitRepoRepositoryProtocolMock) {
        repository.perform(.getRepoReliabilityMultiplier(completion: .any, perform: { completion in
            var gitRepoReliabilityMultiplier = GitRepoReliabilityMultiplierModel()
            gitRepoReliabilityMultiplier.enable = true
            gitRepoReliabilityMultiplier.multiplier = 1
            completion(.success(gitRepoReliabilityMultiplier))
        }))
    }

    fileprivate func givenExecuteCalculator(_ calculatorUseCase: ReliabilityRepoCalculatorUseCaseMock) {
        calculatorUseCase.given(.execute(repoStats: .any, multiplier: .any, willReturn: 50))
    }

    fileprivate func verifyInterfaceAdapter(_ presenter: FetchGitRepositoriesInterfaceAdapterMock) {
        presenter.verify(.doing())
        presenter.verify(.failure(withError: .any), count: .never)
        presenter.verify(.done(data: .matching { (repositories) -> Bool in
            let repo = repositories.first
            XCTAssert(repo!.reliability.isEnable)
            XCTAssertEqual(50, repo?.reliability.score)
            return repo!.reliability.isEnable
            }))
    }

    func testFetchRepository() {
        let repository = GitRepoRepositoryProtocolMock()
        let presenter = FetchGitRepositoriesInterfaceAdapterMock(sequencing: .inWritingOrder, stubbing: .wrap)
        let calculatorUseCase = ReliabilityRepoCalculatorUseCaseMock()
        let configRemoteRepository = ConfigRepositoryProtocolMock()

        perfomExecuteList(repository)
        performExecuteGetRepoReliabilityMultiplier(repository)
        givenExecuteCalculator(calculatorUseCase)

        let useCase = FetchGitRepositoriesUseCase(
            gitRepoRepository: repository,
            reliabilityCalculatorUseCase: calculatorUseCase
        )
        useCase.delegateInterfaceAdapter = presenter
        useCase.execute(term: "test")
        verifyInterfaceAdapter(presenter)
    }
}
