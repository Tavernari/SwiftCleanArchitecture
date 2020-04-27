//
//  GitPullRequestsViewModelTests.swift
//  PresentationTests
//
//  Created by Victor C Tavernari on 08/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import DataLayer
import Domain
@testable import Presentation
import XCTest

class GitPullRequestsViewModelTests: XCTestCase {
    func testListPullRequests() {
        let resultExpectation = XCTestExpectation(description: "Waiting pull requests")
        let loadingExpectation = XCTestExpectation(description: "Waiting loading status")
        let data = GitPullRequestData()
        let dataSource = MockGitPullRequestDataSource(result: [data])
        let repository = GitPullRequestRepository(dataSource: dataSource)
        let useCase = FetchPullRequestsUseCase(repository: repository)
        let viewModel = ListOfPullRequestsViewModel(listPullRequestsUseCase: useCase)
        useCase.delegateInterfaceAdapter = viewModel

        viewModel.pullRequests.observe { pullRequests in
            guard pullRequests.isEmpty == false else {
                return
            }

            resultExpectation.fulfill()
            XCTAssertEqual(viewModel.pullRequests.value.count, 1)
        }

        viewModel.isLoading.observe { isLoading in
            if isLoading == true {
                loadingExpectation.fulfill()
            }
        }

        viewModel.load(repo: GitRepositoryModel())

        wait(for: [resultExpectation, loadingExpectation], timeout: 2)
    }

    func testSelectPullRequest() {
        let resultExpectation = XCTestExpectation(description: "Waiting pull requests")
        let loadingExpectation = XCTestExpectation(description: "Waiting loading status")
        let repo = GitRepositoryModel()
        var data1 = GitPullRequestData()
        data1.user = .init()
        data1.user.login = "data1"
        data1.number = 400
        var data2 = GitPullRequestData()
        data2.user = .init()
        data2.user.login = "data2"
        data2.number = 500

        let dataSource = MockGitPullRequestDataSource(result: [data1, data2])
        let repository = GitPullRequestRepository(dataSource: dataSource)
        let useCase = FetchPullRequestsUseCase(repository: repository)
        let viewModel = ListOfPullRequestsViewModel(listPullRequestsUseCase: useCase)
        useCase.delegateInterfaceAdapter = viewModel

        viewModel.pullRequests.observe { pullRequests in
            guard pullRequests.isEmpty == false else {
                return
            }

            resultExpectation.fulfill()
            XCTAssertEqual(viewModel.pullRequests.value.count, 2)

            viewModel.select(index: 0)
            XCTAssertEqual(viewModel.route.value, .showPullRequestDetail(id: data1.number, repo: repo))
        }

        viewModel.isLoading.observe { isLoading in
            if isLoading {
                loadingExpectation.fulfill()
            }
        }

        viewModel.load(repo: repo)

        wait(for: [resultExpectation, loadingExpectation], timeout: 2)
    }
}
