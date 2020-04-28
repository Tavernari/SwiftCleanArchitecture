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
    func testFetchRepository() {
        let repository = GitRepoRepositoryProtocolMock()
        let presenter = FetchGitRepositoriesInterfaceAdapterMock(sequencing: .inWritingOrder, stubbing: .wrap)
        let calculatorUseCase = ReliabilityRepoCalculatorUseCaseMock()
        let configRemoteRepository = ConfigRepositoryProtocolMock()

        repository.perform(.list(term: .any, completion: .any, perform: { _, completion in
            completion(.success([GitRepositoryModel()]))
        }))

        repository.perform(.getRepoReliabilityMultiplier(completion: .any, perform: { completion in
            var gitRepoReliabilityMultiplier = GitRepoReliabilityMultiplierModel()
            gitRepoReliabilityMultiplier.enable = true
            gitRepoReliabilityMultiplier.multiplier = 1
            completion(.success(gitRepoReliabilityMultiplier))
        }))

        calculatorUseCase.given(.execute(repoStats: .any, multiplier: .any, willReturn: 50))

        let useCase = FetchGitRepositoriesUseCase(
            gitRepoRepository: repository,
            reliabilityCalculatorUseCase: calculatorUseCase
        )
        useCase.delegateInterfaceAdapter = presenter

        useCase.execute(term: "test")

        presenter.verify(.doing())
        presenter.verify(.failure(withError: .any), count: .never)
        presenter.verify(.done(data: .matching { (repositories) -> Bool in
            let repo = repositories.first
            XCTAssert(repo!.reliability.isEnable)
            XCTAssertEqual(50, repo?.reliability.score)
            return repo!.reliability.isEnable
        }))
    }
}
