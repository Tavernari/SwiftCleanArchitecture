//
//  RepositoriesTableViewModelTests.swift
//  PresentationTests
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import DataLayer
import Domain
@testable import Presentation
import XCTest

class MockGitRepoDataSource: GitRepoDataSource {
    private let result: GithubResponseData
    init(result: GithubResponseData) {
        self.result = result
    }

    func list(term _: String, completion: @escaping (Result<GithubResponseData, Error>) -> Void) {
        completion(.success(result))
    }

    func stats(repo _: GitRepository, completion: @escaping (Result<GitRepoStatsModel, Error>) -> Void) {
        completion(.success(.init()))
    }
}

class RepositoriesTableViewModelTests: XCTestCase {
    func testListRepository() {
        let expectationLoadingStatus = XCTestExpectation(description: "Wait for loading status")
        let expectationRepositories = XCTestExpectation(description: "Wait for repositories results")
        var responseData = GithubResponseData()
        let data = GithubRepositoryData()
        responseData.items = [data, data]
        let datasource = MockGitRepoDataSource(result: responseData)
        let configDataSource = MemoryGitRepoRemoteConfigDataSource(enable: true, multiplier: 4)
        let repository = DataLayer.GitRepoRepository(gitRepoDataSource: datasource, remoteConfigDataSource: configDataSource)
        let useCase = FetchGitRepositoriesUseCase(
            gitRepoRepository: repository,
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

        var responseData = GithubResponseData()

        var data1 = GithubRepositoryData()
        data1.name = "repository1DataName"
        data1.owner = .init()
        data1.owner.login = "repository1DataAuthor"

        var data2 = GithubRepositoryData()
        data2.name = "repository2DataName"
        data2.owner = .init()
        data2.owner.login = "repository2DataAuthor"

        responseData.items = [data1, data2]

        let datasource = MockGitRepoDataSource(result: responseData)
        let configDataSource = MemoryGitRepoRemoteConfigDataSource(enable: false, multiplier: 4)
        let repository = GitRepoRepository(gitRepoDataSource: datasource, remoteConfigDataSource: configDataSource)
        let useCase = FetchGitRepositoriesUseCase(
            gitRepoRepository: repository,
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

            let index = 1
            let gitRepo = repositories[index]
            XCTAssertEqual(viewModel.repositories.value.count, 2)
            expectationRepositories.fulfill()
            viewModel.select(index: index)
            XCTAssertEqual(viewModel.route.value, ListOfRepositoriesViewModelRoute.showPullRequests(repo: gitRepo))
        }

        wait(for: [expectationRepositories, expectationLoadingStatus], timeout: 1)
    }
}
