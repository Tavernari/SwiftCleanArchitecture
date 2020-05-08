//
//  RepositoriesTableViewModelTests.swift
//  PresentationTests
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import DataLayer
import DomainLayer
import Firebase
@testable import PresentationLayer
import XCTest

class RepositoriesTableViewModelTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    func testListRepository() {
        let expectationLoadingStatus = XCTestExpectation(description: "Wait for loading status")
        let expectationRepositories = XCTestExpectation(description: "Wait for repositories results")
        let useCase = FetchGitRepositoriesUseCaseProtocolMock()
        useCase.perform(.execute(term: .any, perform: { _ in
            useCase.delegateInterfaceAdapter?.doing()
            useCase.delegateInterfaceAdapter?.done(data: [GitRepositoryModel(), GitRepositoryModel()])
        }))

        let analyticsInterface = GitRepositoriesListViewModelAnalyticsProtocolMock()
        let viewModel = GitRepositoriesListViewModel(
            fetchGitRepositoriesUseCase: useCase,
            delegateAnalyticsInterface: analyticsInterface
        )
        useCase.given(.delegateInterfaceAdapter(getter: viewModel))

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

        viewModel.search(term: "Java")

        analyticsInterface.verify(.itemSelected(name: .any), count: .never)
        analyticsInterface.verify(.searched(term: .value("Java")))

        wait(for: [expectationRepositories, expectationLoadingStatus], timeout: 1)
    }

    func testSelectRepository() {
        let expectationLoadingStatus = XCTestExpectation(description: "Wait for loading status")
        let expectationRepositories = XCTestExpectation(description: "Wait for repositories results")

        var data1 = GitRepositoryModel()
        data1.name = "repository1DataName"
        data1.author = "repository1DataAuthor"

        var data2 = GitRepositoryModel()
        data2.name = "repository2DataName"
        data2.author = "repository2DataAuthor"

        let analyticsInterfaceMock = GitRepositoriesListViewModelAnalyticsProtocolMock()

        let useCaseMock = FetchGitRepositoriesUseCaseProtocolMock()
        useCaseMock.perform(.execute(term: .any, perform: { _ in
            useCaseMock.delegateInterfaceAdapter?.doing()
            useCaseMock.delegateInterfaceAdapter?.done(data: [data1, data2])
        }))

        let viewModel = GitRepositoriesListViewModel(
            fetchGitRepositoriesUseCase: useCaseMock,
            delegateAnalyticsInterface: analyticsInterfaceMock
        )
        useCaseMock.given(.delegateInterfaceAdapter(getter: viewModel))

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
            XCTAssertEqual(viewModel.route.value, GitRepositoriesListViewModelRoute.showPullRequests(repo: gitRepo))
        }

        viewModel.search(term: "Java")

        analyticsInterfaceMock.verify(.itemSelected(name: .value(data2.name)))

        wait(for: [expectationRepositories, expectationLoadingStatus], timeout: 1)
    }
}
