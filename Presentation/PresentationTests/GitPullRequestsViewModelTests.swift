//
//  GitPullRequestsViewModelTests.swift
//  PresentationTests
//
//  Created by Victor C Tavernari on 08/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import DataSource
import Domain
@testable import Presentation
import XCTest

class GitPullRequestsViewModelTests: XCTestCase {
    func testListPullRequests() {
        let resultExpectation = XCTestExpectation(description: "Waiting pull requests")
        let loadingExpectation = XCTestExpectation(description: "Waiting loading status")
        let data = GitPullRequest()
        let dataSource = MockGitPullRequestDataSource(result: [data])
        let repository = GitPullRequestDataRepository(dataSource: dataSource)
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

        viewModel.load(repo: GitRepository())

        wait(for: [resultExpectation, loadingExpectation], timeout: 2)
    }

    func testSelectPullRequest() {
        let resultExpectation = XCTestExpectation(description: "Waiting pull requests")
        let loadingExpectation = XCTestExpectation(description: "Waiting loading status")
        let repo = GitRepository()
        var data1 = GitPullRequest()
        data1.author = "data1"
        data1.id = 400
        var data2 = GitPullRequest()
        data2.author = "data2"
        data2.id = 500

        let dataSource = MockGitPullRequestDataSource(result: [data1, data2])
        let repository = GitPullRequestDataRepository(dataSource: dataSource)
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
            XCTAssertEqual(viewModel.route.value, .showPullRequestDetail(id: data1.id, repo: repo))
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
