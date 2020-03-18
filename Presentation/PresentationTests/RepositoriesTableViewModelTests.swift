//
//  RepositoriesTableViewModelTests.swift
//  PresentationTests
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import XCTest
import Domain
import DataSource
@testable import Presentation

class MockGitRepoDataSource: GitRepoDataSource {

    private let result: [GitRepository]
    init(result: [GitRepository]){
        self.result = result
    }

    func list(term: String, completion: @escaping (Result<[GitRepository], Error>) -> Void) {
        completion(.success(self.result))
    }
}

class RepositoriesTableViewModelTests: XCTestCase {
    func testListRepository() {
        let data = GitRepository()
        let datasource = MockGitRepoDataSource(result: [data, data])
        let repository = DataSource.GitRepoRepository(dataSource: datasource)
        let useCase = DoListGitRepositoryUseCase(repository: repository)
        let viewModel = RepositoriesTableViewModel(listGitRepositoryUseCase: useCase)
        var statusBuffer = [ViewModelLoadStatus]()
        viewModel.status.observe(listener: { status in statusBuffer.append( status )})
        viewModel.search(term: "Java")
        XCTAssertEqual(viewModel.repositories.value.count, 2)
        XCTAssertEqual(statusBuffer, [.none, .loading, .loaded])
    }

    func testSelectRepository() {
        var data1 = GitRepository()
        data1.name = "repository1DataName"
        data1.author = "repository1DataAuthor"

        var data2 = GitRepository()
        data2.name = "repository2DataName"
        data2.author = "repository2DataAuthor"

        let datasource = MockGitRepoDataSource(result: [data1, data2])
        let repository = DataSource.GitRepoRepository(dataSource: datasource)
        let useCase = DoListGitRepositoryUseCase(repository: repository)
        let viewModel = RepositoriesTableViewModel(listGitRepositoryUseCase: useCase)
        var statusBuffer = [ViewModelLoadStatus]()
        viewModel.status.observe(listener: { status in statusBuffer.append( status )})
        viewModel.search(term: "Java")
        viewModel.select(index: 1)
        XCTAssertEqual(viewModel.repositories.value.count, 2)
        XCTAssertEqual(viewModel.route.value, .showPullRequests(repo: data2))
        XCTAssertEqual(statusBuffer, [.none, .loading, .loaded])
    }
}
