//
//  ListGitRepositoryUseCaseTests.swift
//  DomainTests
//
//  Created by Victor C Tavernari on 04/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

@testable import Domain
import SwiftyMocky
import XCTest

class ListGitRepositoryUseCaseTests: XCTestCase {
    func testFetchRepository() {
        let repository = GitRepoRepositoryMock()
        let presenter = FetchGitRepositoriesInterfaceAdapterMock(sequencing: .inWritingOrder, stubbing: .wrap)
        let calculatorUseCase = ReliabilityRepoCalculatorUseCaseMock()
        let configRemoteRepository = ConfigRepositoryMock()

        repository.perform(.list(term: .any, completion: .any, perform: { _, completion in
            completion(.success([GitRepository()]))
        }))

        configRemoteRepository.perform(.gitRepoReliabilityMultiplier(completion: .any, perform: { completion in
            var gitRepoReliabilityMultiplier = GitRepoReliabilityMultiplier()
            gitRepoReliabilityMultiplier.enable = true
            gitRepoReliabilityMultiplier.multiplier = 1
            completion(.success(gitRepoReliabilityMultiplier))
        }))

        calculatorUseCase.given(.execute(repoStats: .any, multiplier: .any, willReturn: 50))

        let useCase = FetchGitRepositoriesUseCase(
            gitRepoRepository: repository,
            configRepository: configRemoteRepository,
            reliabilityCalculatorUseCase: calculatorUseCase
        )
        useCase.delegateInterfaceAdapter = presenter

        useCase.execute(term: "test")

        presenter.verify(.fetching())
        presenter.verify(.fetchFailure(withError: .any), count: .never)
        presenter.verify(.fetched(data: .matching { (repositories) -> Bool in
            let repo = repositories.first
            XCTAssert(repo!.isReliabilityEnabled)
            XCTAssertEqual(50, repo?.reliabilityScore)
            return repo!.isReliabilityEnabled
        }))
    }

//    func testListRepositoryWithFetchRepositoryError() {
//        let error = ListGitRepositoryUseCaseError.failWhenFetchRepository(message: "Test error")
//        let expectation = XCTestExpectation(description: "Waiting results")
//        let repository = MockRepoRepository(result: [], error: error)
//        let configRemoteRepository = MockConfigRepository(enable: true, error: nil)
//        let calculator = MockRelibilityCalculator()
//        let listRepository = DoListGitRepositoryUseCase(
//            gitRepoRepository: repository,
//            configRepository: configRemoteRepository, reliabilityCalculatorRepository: calculator)
//        listRepository.execute(term: "") { (result) in
//            guard case .failure(let failureError) = result else{
//                return
//            }
//
//            guard case .failWhenFetchRepository(let errorMessage) = failureError else {
//                return
//            }
//
//            XCTAssertEqual("Test error", errorMessage)
//            expectation.fulfill()
//        }
//
//        self.wait(for: [expectation], timeout: 2)
//    }
//
//    func testListRepositoryWithFetchConfigRepositoryError() {
//        let error = ListGitRepositoryUseCaseError.failWhenGetReliabilityMultiplier(message: "Multiplier error")
//        let expectation = XCTestExpectation(description: "Waiting results")
//        let repository = MockRepoRepository(result: [.init()], error: nil)
//        let configRemoteRepository = MockConfigRepository(enable: true, error: error)
//        let calculator = MockRelibilityCalculator()
//        let listRepository = DoListGitRepositoryUseCase(
//            gitRepoRepository: repository,
//            configRepository: configRemoteRepository, reliabilityCalculatorRepository: calculator)
//        listRepository.execute(term: "") { (result) in
//            guard case .failure(let failureError) = result else{
//                return
//            }
//
//            guard case .failWhenGetReliabilityMultiplier(let errorMessage) = failureError else {
//                return
//            }
//
//            XCTAssertEqual("Multiplier error", errorMessage)
//            expectation.fulfill()
//        }
//
//        self.wait(for: [expectation], timeout: 2)
//    }
}
