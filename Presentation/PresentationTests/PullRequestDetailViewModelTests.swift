//
//  PullRequestDetailViewModelTests.swift
//  PresentationTests
//
//  Created by Victor C Tavernari on 08/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import XCTest
import Domain
import DataSource
@testable import Presentation

class PullRequestDetailViewModelTests: XCTestCase {
    func testLoadDetail() {
        var data = GitPullRequest()
        data.author = "author"
        data.id = 10

        let dataSource = MockGitPullRequestDataSource(result: data)
        let repository = GitPullRequestDataRepository(dataSource: dataSource)
        let useCase = DoGetPullRequestDetailUseCase(repository: repository)
        let viewModel = PullRequestDetailViewModel(useCase: useCase)

        var statusBuffer = [ViewModelLoadStatus]()
        viewModel.status.observe(listener: { status in statusBuffer.append( status )})

        viewModel.load(data: GitPullRequestDetailViewModelInputData(repo: GitRepository(), id: 10))

        XCTAssertEqual(viewModel.pullRequest.value, data)
        XCTAssertEqual(statusBuffer, [.none, .loading, .loaded])
    }
}
