//
//  DataSourceTests.swift
//  DataSourceTests
//
//  Created by Victor C Tavernari on 01/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

@testable import DataLayer
import DomainLayer
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
        let dto = LoginDTO(data: LoginResponseData(token: logedIn ? "token123XXX99" : ""))
        completion(.success(dto))
    }
}

extension MockDataSource {
    func recoverable() -> Self {
        recovered = true

        return self
    }

    func logable() -> Self {
        logedIn = true

        return self
    }
}

extension SignInRepository {
    func configRepository(dataSource: SignInDataSourceProtocol) -> SignInRepository {
        let repository = SignInRepository(signInDataSource: dataSource)
        return repository
    }
}

class DataSourceTests: XCTestCase {
    var mockDataSource: MockDataSource!
    var repository: SignInRepository!

    override func setUp() {
        mockDataSource = MockDataSource()
        repository = SignInRepository(signInDataSource: mockDataSource)
    }

    func assertRecoveryResult(result: Result<Bool, Error>,
                              expectation: XCTestExpectation? = nil,
                              assert: Bool? = true) {
        guard let value = try? result.handle(), value == assert else {
            XCTFail("failed waiting for success response")
            return
        }

        if expectation != nil { expectation?.fulfill() }
        XCTAssertEqual(value, assert)
    }

    func assertLoginResult(result: Result<LoginModel, Error>,
                           assert: Bool? = false) {
        guard let value = try? result.handle() else {
            XCTFail("failed waiting for success response")
            return
        }

        XCTAssertNotNil(value)
        XCTAssertEqual(value.token.isEmpty, assert)
    }

    func testRecoveryPassword_returnTrue() {
        repository
            .configRepository(dataSource: mockDataSource.recoverable())
            .recoverPassword(email: "lucas@email.com") { result in
                self.assertRecoveryResult(result: result)
            }
    }

    func testRecoveryPassword_returnFalse() {
        repository.recoverPassword(email: "lucas@email.com") { result in
            self.assertRecoveryResult(result: result, assert: false)
        }
    }

    func testIntegrationRecoverPasswordRepository() {
        let expectation = XCTestExpectation(description: "waiting result")
        repository
            .configRepository(dataSource: SignInDataSource())
            .recoverPassword(email: "lucas@email.com") { result in
                self.assertRecoveryResult(result: result, expectation: expectation)
            }

        wait(for: [expectation], timeout: 1)
    }

    func testLogin_returnTrue() {
        repository
            .configRepository(dataSource: mockDataSource.logable())
            .login(email: "lucas@email.com", password: "pass123") { result in
                self.assertLoginResult(result: result)
            }
    }

    func testLogin_returnFalse() {
        repository.login(email: "lucas@email.com", password: "pass123") { result in
            self.assertLoginResult(result: result, assert: true)
        }
    }

    func testIntegrationLoginRepository() {
        let expectation = XCTestExpectation(description: "waiting login result")
        repository
            .configRepository(dataSource: SignInDataSource())
            .login(email: "lucas@email.com", password: "pass123") { result in
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
