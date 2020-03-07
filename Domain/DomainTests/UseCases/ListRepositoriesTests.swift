//
//  ListRepositoriesTests.swift
//  DomainTests
//
//  Created by Victor C Tavernari on 04/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import XCTest
@testable import Domain

class ListRepositoriesTests: XCTestCase {
    func testListRepositoryWithoutCompletionHandler() {
        let repository = MockRepoRepository(result: [], error: nil)
        let listRepository = ListRepositories(repository: repository).with(input: "JS")
        XCTAssertThrowsError(try listRepository.run(completionHandler: nil))
    }

    func testListRepositoryWithValues() {
        let repositoryData = Repository(name: "name", author: "author", description: "description", image: "image", starCount: 5, forkCount: 0, issuesCount: 0)
        let repositories = MockRepoRepository(result: [repositoryData], error: nil)
        let expectation = XCTestExpectation(description: "waiting result")

        let listRepository = ListRepositories(repository: repositories).with(input: "js")
        try! listRepository.run { (result, error) in
            XCTAssertEqual(result?.isEmpty, false)
            XCTAssertEqual(result?.first?.name, "name")

            expectation.fulfill()
        }

        self.wait(for: [expectation], timeout: 2)
    }
}
