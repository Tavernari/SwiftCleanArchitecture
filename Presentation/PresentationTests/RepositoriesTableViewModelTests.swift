//
//  RepositoriesTableViewModelTests.swift
//  PresentationTests
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import DataSource
import Domain
@testable import Presentation
import XCTest

class MockGitRepoDataSource: GitRepoDataSource {
    func stats(repo _: GitRepository, completion: @escaping (Result<GitRepoStatsModel, Error>) -> Void) {
        completion(.success(.init()))
    }

    private let result: [GitRepository]
    init(result: [GitRepository]) {
        self.result = result
    }

    func list(term _: String, completion: @escaping (Result<[GitRepository], Error>) -> Void) {
        completion(.success(result))
    }
}

class RepositoriesTableViewModelTests: XCTestCase {
    func testListRepository() {
        let expectationLoadingStatus = XCTestExpectation(description: "Wait for loading status")
        let expectationRepositories = XCTestExpectation(description: "Wait for repositories results")
        let data = GitRepository()
        let datasource = MockGitRepoDataSource(result: [data, data])
        let configDataSource = MemoryConfigDataSource(enable: true, multiplier: 4)
        let configRepository = ConfigDataRepository(dataSource: configDataSource)
        let repository = DataSource.GitRepoRepository(gitRepoDataSource: datasource)
        let useCase = FetchGitRepositoriesUseCase(
            gitRepoRepository: repository,
            configRepository: configRepository,
            reliabilityCalculatorUseCase: ReliabilityRepoCalculator()
        )
        let viewModel = ListOfRepositoriesViewModel(fetchGitRepositoriesUseCase: useCase)
        useCase.delegateInterfaceAdapter = viewModel
        viewModel.search(term: "Java")

        viewModel.repositories.observe { repositories in
            guard repositories.isEmpty == false else {
                return
            }

            XCTAssertEqual(viewModel.repositories.value.count, 2)
            expectationRepositories.fulfill()
        }

        viewModel.isLoading.observe { isLoading in
            if isLoading == true {
                expectationLoadingStatus.fulfill()
            }
        }

        wait(for: [expectationRepositories, expectationLoadingStatus], timeout: 1)
    }

    func testSelectRepository() {
        let expectationLoadingStatus = XCTestExpectation(description: "Wait for loading status")
        let expectationRepositories = XCTestExpectation(description: "Wait for repositories results")

        var data1 = GitRepository()
        data1.name = "repository1DataName"
        data1.author = "repository1DataAuthor"

        var data2 = GitRepository()
        data2.name = "repository2DataName"
        data2.author = "repository2DataAuthor"

        let datasource = MockGitRepoDataSource(result: [data1, data2])
        let configDataSource = MemoryConfigDataSource(enable: false, multiplier: 4)
        let configRepository = ConfigDataRepository(dataSource: configDataSource)
        let repository = DataSource.GitRepoRepository(gitRepoDataSource: datasource)
        let useCase = FetchGitRepositoriesUseCase(
            gitRepoRepository: repository,
            configRepository: configRepository,
            reliabilityCalculatorUseCase: ReliabilityRepoCalculator()
        )
        let viewModel = ListOfRepositoriesViewModel(fetchGitRepositoriesUseCase: useCase)
        useCase.delegateInterfaceAdapter = viewModel
        viewModel.search(term: "Java")

        viewModel.repositories.observe { repositories in
            guard repositories.isEmpty == false else {
                return
            }

            XCTAssertEqual(viewModel.repositories.value.count, 2)
            expectationRepositories.fulfill()
        }

        viewModel.isLoading.observe { isLoading in
            if isLoading == true {
                expectationLoadingStatus.fulfill()
            }
        }

        viewModel.repositories.observe { repositories in
            guard repositories.isEmpty == false else {
                return
            }

            XCTAssertEqual(viewModel.repositories.value.count, 2)
            expectationRepositories.fulfill()
            viewModel.select(index: 1)
            XCTAssertEqual(.showPullRequests(repo: data2), viewModel.route.value)
        }

        wait(for: [expectationRepositories, expectationLoadingStatus], timeout: 1)
    }
}
