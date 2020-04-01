//
//  ListRepositoriesTests.swift
//  DomainTests
//
//  Created by Victor C Tavernari on 04/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import XCTest
@testable import Domain

class ListRepositoriesTests: XCTestCase {
    func testListRepository() {
        let expectation = XCTestExpectation(description: "Waiting results")
        let repository = MockRepoRepository(result: [.init()], error: nil)
        let configRemoteRepository = MockConfigRepository(enable: true, error: nil)
        let calculator = MockRelibilityCalculator()
        let listRepository = DoListGitRepositoryUseCase(
            gitRepoRepository: repository,
            configRepository: configRemoteRepository, reliabilityCalculatorRepository: calculator)
        listRepository.execute(term: "") { (result) in
            guard case .success(let data) = result else {
                return
            }

            XCTAssertEqual(data.first?.isReliabilityEnabled, true)
            XCTAssertEqual(data.first?.reliabilityScore, 1.0)
            expectation.fulfill()
        }

        self.wait(for: [expectation], timeout: 2)
    }

    func testListRepositoryWithFetchRepositoryError() {
        let error = ListGitRepositoryUseCaseError.failWhenFetchRepository(message: "Test error")
        let expectation = XCTestExpectation(description: "Waiting results")
        let repository = MockRepoRepository(result: [], error: error)
        let configRemoteRepository = MockConfigRepository(enable: true, error: nil)
        let calculator = MockRelibilityCalculator()
        let listRepository = DoListGitRepositoryUseCase(
            gitRepoRepository: repository,
            configRepository: configRemoteRepository, reliabilityCalculatorRepository: calculator)
        listRepository.execute(term: "") { (result) in
            guard case .failure(let failureError) = result else{
                return
            }

            guard case .failWhenFetchRepository(let errorMessage) = failureError else {
                return
            }

            XCTAssertEqual("Test error", errorMessage)
            expectation.fulfill()
        }

        self.wait(for: [expectation], timeout: 2)
    }

    func testListRepositoryWithFetchConfigRepositoryError() {
        let error = ListGitRepositoryUseCaseError.failWhenGetReliabilityMultiplier(message: "Multiplier error")
        let expectation = XCTestExpectation(description: "Waiting results")
        let repository = MockRepoRepository(result: [.init()], error: nil)
        let configRemoteRepository = MockConfigRepository(enable: true, error: error)
        let calculator = MockRelibilityCalculator()
        let listRepository = DoListGitRepositoryUseCase(
            gitRepoRepository: repository,
            configRepository: configRemoteRepository, reliabilityCalculatorRepository: calculator)
        listRepository.execute(term: "") { (result) in
            guard case .failure(let failureError) = result else{
                return
            }

            guard case .failWhenGetReliabilityMultiplier(let errorMessage) = failureError else {
                return
            }

            XCTAssertEqual("Multiplier error", errorMessage)
            expectation.fulfill()
        }

        self.wait(for: [expectation], timeout: 2)
    }

}
