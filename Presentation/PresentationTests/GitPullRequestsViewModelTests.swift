//
//  GitPullRequestsViewModelTests.swift
//  PresentationTests
//
//  Created by Victor C Tavernari on 08/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import XCTest
import Domain
import DataSource
@testable import Presentation

class GitPullRequestsViewModelTests: XCTestCase {
    func testListPullRequests() {
        let data = GitPullRequest()
        let dataSource = MockGitPullRequestDataSource(result: [data])
        let repository = GitPullRequestDataRepository(dataSource: dataSource)
        let useCase = DoListPullRequestsUseCase(repository: repository)
        let viewModel = GitListPullRequestViewModel(listPullRequestsUseCase: useCase)
        var statusBuffer = [ViewModelLoadStatus]()
        viewModel.status.observe(listener: { status in statusBuffer.append( status )})
        viewModel.load(repo: GitRepository())
        XCTAssertEqual(viewModel.pullRequests.value.count, 1)
        XCTAssertEqual(statusBuffer, [.none, .loading, .loaded])
    }

    func testSelectPullRequest() {
        let repo = GitRepository()
        var data1 = GitPullRequest()
        data1.author = "data1"
        data1.id = 400
        var data2 = GitPullRequest()
        data2.author = "data2"
        data2.id = 500

        let dataSource = MockGitPullRequestDataSource(result: [data1, data2])
        let repository = GitPullRequestDataRepository(dataSource: dataSource)
        let useCase = DoListPullRequestsUseCase(repository: repository)
        let viewModel = GitListPullRequestViewModel(listPullRequestsUseCase: useCase)
        var statusBuffer = [ViewModelLoadStatus]()
        viewModel.status.observe(listener: { status in statusBuffer.append( status )})
        viewModel.load(repo: repo)
        viewModel.select(index: 0)
        XCTAssertEqual(viewModel.pullRequests.value.count, 2)
        XCTAssertEqual(viewModel.route.value, .showPullRequestDetail(id: data1.id, repo: repo))
        XCTAssertEqual(statusBuffer, [.none, .loading, .loaded])

    }
}
