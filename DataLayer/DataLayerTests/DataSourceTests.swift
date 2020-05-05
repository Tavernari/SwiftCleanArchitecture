//
//  DataSourceTests.swift
//  DataSourceTests
//
//  Created by Victor C Tavernari on 01/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

@testable import DataLayer
import XCTest

class MockDataSource: SignInDataSourceProtocol {
    var recovered: Bool

    init(recovered: Bool) {
        self.recovered = recovered
    }

    func recover(email _: String, completion: (Result<RecoveryPasswordDTO, Error>) -> Void) {
        let dto = RecoveryPasswordDTO(data: RecoveryPasswordResponseData(recovered: recovered))
        completion(.success(dto))
    }
}

class DataSourceTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testRecoveryPassword_returnTrue() {
        let repository = SignInRepository(signInDataSource: MockDataSource(recovered: true))
        repository.recoverPassword(email: "lucas@email.com") { result in
            switch result {
            case let .success(value):
                XCTAssert(value)
            default:
                XCTFail("failed waiting for success response")
            }
        }
    }

    func testRecoveryPassword_returnFalse() {
        let repository = SignInRepository(signInDataSource: MockDataSource(recovered: false))
        repository.recoverPassword(email: "lucas@email.com") { result in
            switch result {
            case let .success(value):
                XCTAssertFalse(value)
            default:
                XCTFail("failed waiting for success response")
            }
        }
    }

    func testIntegrationRecoverPasswordRepository() {
        let expectation = XCTestExpectation(description: "waiting result")

        let repository = SignInRepository(signInDataSource: SignInDataSource())
        repository.recoverPassword(email: "lucas@email.com") { result in
            switch result {
            case let .success(value):
                XCTAssert(value)
                expectation.fulfill()
            default:
                XCTFail("failed waiting for success response")
            }
        }

        wait(for: [expectation], timeout: 1)
    }
}
