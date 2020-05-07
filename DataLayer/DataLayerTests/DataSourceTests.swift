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
    var logedIn: Bool

    init(recovered: Bool? = false, logedIn: Bool? = false) {
        self.recovered = recovered!
        self.logedIn = logedIn!
    }

    func recover(email _: String, completion: (Result<RecoveryPasswordDTO, Error>) -> Void) {
        let dto = RecoveryPasswordDTO(data: RecoveryPasswordResponseData(recovered: recovered))
        completion(.success(dto))
    }

    func login(email _: String, password _: String, completion: (Result<LoginDTO, Error>) -> Void) {
        let dto = LoginDTO(data: LoginResponseData(token: "token123XXX99"))
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

    func testLogin_returnTrue() {
        let repository = SignInRepository(signInDataSource: MockDataSource(logedIn: true))
        repository.login(email: "lucas@email.com", password: "pass123") { result in
            switch result {
            case let .success(value):
                XCTAssertNotNil(value)
            default:
                XCTFail("failed waiting for success response")
            }
        }
    }

    func testLogin_returnFalse() {
        let repository = SignInRepository(signInDataSource: MockDataSource(logedIn: false))
        repository.login(email: "lucas@email.com", password: "pass123") { result in
            switch result {
            case let .success(value):
                XCTAssertNotNil(value)
            default:
                XCTFail("failed waiting for success response")
            }
        }
    }

    func testIntegrationLoginRepository() {
        let expectation = XCTestExpectation(description: "waiting login result")

        let repository = SignInRepository(signInDataSource: MockDataSource(logedIn: true))
        repository.login(email: "lucas@email.com", password: "pass123") { result in
            switch result {
            case let .success(response):
                XCTAssertEqual(response.token, "token123XXX99")
                expectation.fulfill()
            default:
                XCTFail("failed waiting success response from login api")
            }
        }

        wait(for: [expectation], timeout: 1)
    }
}
