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

    private func createUseCase() -> FetchGitRepositoriesUseCaseProtocolMock {
        var data1 = GitRepositoryModel()
        data1.name = "repository1DataName"
        data1.author = "repository1DataAuthor"

        var data2 = GitRepositoryModel()
        data2.name = "repository2DataName"
        data2.author = "repository2DataAuthor"

        let useCaseMock = FetchGitRepositoriesUseCaseProtocolMock()
        useCaseMock.perform(.execute(term: .any, perform: { _ in
            useCaseMock.delegateInterfaceAdapter?.doing()
            useCaseMock.delegateInterfaceAdapter?.done(data: [data1, data2])
        }))

        return useCaseMock
    }

    func testListRepository() {
        let useCase = createUseCase()

        let analyticsInterface = GitRepositoriesListViewModelAnalyticsProtocolMock()
        let viewModel = GitRepositoriesListViewModel(
            fetchGitRepositoriesUseCase: useCase,
            delegateAnalyticsInterface: analyticsInterface
        )
        useCase.given(.delegateInterfaceAdapter(getter: viewModel))

        viewModel.search(term: "Java")

        analyticsInterface.verify(.screen())
        analyticsInterface.verify(.itemSelected(name: .any), count: .never)
        analyticsInterface.verify(.searched(term: .value("Java")))
        XCTAssertEqual(viewModel.repositories.value.count, 2)
    }

    func testSelectRepository() {
        let analyticsInterfaceMock = GitRepositoriesListViewModelAnalyticsProtocolMock()
        let useCaseMock = createUseCase()
        let viewModel = GitRepositoriesListViewModel(
            fetchGitRepositoriesUseCase: useCaseMock,
            delegateAnalyticsInterface: analyticsInterfaceMock
        )
        useCaseMock.given(.delegateInterfaceAdapter(getter: viewModel))

        viewModel.search(term: "Swift")
        viewModel.select(index: 1)

        analyticsInterfaceMock.verify(.screen())
        analyticsInterfaceMock.verify(.searched(term: .value("Swift")))
        analyticsInterfaceMock.verify(.itemSelected(name: .value("repository2DataName")))

        let gitRepoSelected = viewModel.repositories.value[1]
        let route = GitRepositoriesListViewModelRoute.showPullRequests(repo: gitRepoSelected)
        XCTAssertEqual(viewModel.route.value, route)
    }
}
