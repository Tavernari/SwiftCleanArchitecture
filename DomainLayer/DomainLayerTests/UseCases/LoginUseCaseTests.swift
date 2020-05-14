//
//  LogInUseCaseTests.swift
//  DomainLayerTests
//
//  Created by Lucas Silveira on 05/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

@testable import DomainLayer
import XCTest

class MockLoginViewModel: LoginUseCaseInterfaceAdapter {
    public init() {}

    var startedAuthAssert = false
    var logedInAssert = false
    var failureOnLoginAssert = false
    var invalidEmailAssert = false
    var invalidPasswordAssert = false

    func startedAuth() {
        XCTAssert(startedAuthAssert)
    }

    func logedIn(loginModel: LoginModel) {
        XCTAssert(logedInAssert)
        XCTAssertNotNil(loginModel.token.isEmpty == !logedInAssert)
    }

    func failureOnLogin() {
        XCTAssert(failureOnLoginAssert)
    }

    func invalidEmail() {
        XCTAssert(invalidEmailAssert)
    }

    func invalidPassword() {
        XCTAssert(invalidPasswordAssert)
    }
}

extension MockLoginViewModel {
    static func makeLoginWithValidEmailAndPassword() -> MockLoginViewModel {
        let mock = MockLoginViewModel()
        mock.startedAuthAssert = true
        mock.logedInAssert = true

        return mock
    }

    static func makeLoginWithFailureReturn() -> MockLoginViewModel {
        let mock = MockLoginViewModel()
        mock.startedAuthAssert = true
        mock.logedInAssert = true
        mock.failureOnLoginAssert = true

        return mock
    }

    static func makeLoginWithInvalidEmailAndPassword() -> MockLoginViewModel {
        let mock = MockLoginViewModel()
        mock.startedAuthAssert = true
        mock.logedInAssert = true
        mock.invalidEmailAssert = true

        return mock
    }

    static func makeLoginWithInvalidPassword() -> MockLoginViewModel {
        let mock = MockLoginViewModel()
        mock.startedAuthAssert = true
        mock.logedInAssert = true
        mock.invalidPasswordAssert = true

        return mock
    }
}

class LoginUseCaseTests: XCTestCase {
    func makeLoginUseCase(viewModel: MockLoginViewModel, customToken: String? = "") -> LoginUseCase {
        var loginModel = LoginModel()
        loginModel.token = customToken!

        let repository = MockSignInRepository(loginResult: .success(loginModel))
        let useCase = LoginUseCase(repository: repository)

        useCase.delegateInterfaceAdapter = viewModel

        return useCase
    }

    func testLoginWithValidEmailAndPassword_shouldReturnTrue() {
        makeLoginUseCase(viewModel: .makeLoginWithValidEmailAndPassword(), customToken: "token123")
            .execute(email: "lucas@email.com", password: "pass123")
    }

    func testLoginWithFailureReturn() {
        makeLoginUseCase(viewModel: .makeLoginWithFailureReturn())
            .execute(email: "lucas@email.com", password: "pass123")
    }

    func testLoginWithInvalidEmailAndPassword_shouldReturnFalse() {
        makeLoginUseCase(viewModel: .makeLoginWithInvalidEmailAndPassword())
            .execute(email: "lucas@email", password: "pass123")
    }

    func testLoginWithInvalidPassword_shouldReturnFalse() {
        makeLoginUseCase(viewModel: .makeLoginWithInvalidPassword())
            .execute(email: "lucas@email.com", password: "pass")
    }
}
