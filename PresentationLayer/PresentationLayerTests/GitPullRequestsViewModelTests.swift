//
//  GitPullRequestsViewModelTests.swift
//  PresentationTests
//
//  Created by Victor C Tavernari on 08/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import DataLayer
import DomainLayer
@testable import PresentationLayer
import XCTest

class GitPullRequestsViewModelTests: XCTestCase {

    fileprivate func createViewModel(result: [GitPullRequestDTO]) -> GitPullRequestsListViewModel {
        let dataSource = MockGitPullRequestDataSource(result: result)
        let repository = GitPullRequestRepository(dataSource: dataSource)
        let useCase = FetchPullRequestsUseCase(repository: repository)
        var viewModel = GitPullRequestsListViewModel(fetchPullRequestsUseCase: useCase)
        useCase.delegateInterfaceAdapter = viewModel
        return viewModel
    }

    func testListPullRequests() {
        let resultExpectation = XCTestExpectation(description: "Waiting pull requests")
        let loadingExpectation = XCTestExpectation(description: "Waiting loading status")
        let data = GitPullRequestDTO()
        let viewModel = createViewModel(result: [data])


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

    fileprivate func createGitPullRequestDTO(login: String, number: Int) -> GitPullRequestDTO {
        var data = GitPullRequestDTO()
        data.user = .init()
        data.user.login = login
        data.number = number
        return data
    }

    func testSelectPullRequest() {
        let resultExpectation = XCTestExpectation(description: "Waiting pull requests")
        let loadingExpectation = XCTestExpectation(description: "Waiting loading status")
        let repo = GitRepositoryModel()
        let data1 = createGitPullRequestDTO(login: "data1", number: 400)
        let data2 = createGitPullRequestDTO(login: "data2", number: 500)
        let viewModel = createViewModel(result: [data1, data2])

        viewModel.pullRequests.observe { pullRequests in
            guard pullRequests.isEmpty == false else { return }
            resultExpectation.fulfill()
            XCTAssertEqual(viewModel.pullRequests.value.count, 2)
            viewModel.select(index: 0)
            XCTAssertEqual(viewModel.route.value, .showPullRequestDetail(id: data1.number, repo: repo))
        }

        viewModel.isLoading.observe { isLoading in
            if isLoading { loadingExpectation.fulfill() }
        }
        
        viewModel.load(repo: repo)
        wait(for: [resultExpectation, loadingExpectation], timeout: 2)
    }
}
