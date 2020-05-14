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
    func makeLoginWithValidEmailAndPassword() -> Self {
        startedAuthAssert = true
        logedInAssert = true

        return self
    }

    func makeLoginWithFailureReturn() -> Self {
        startedAuthAssert = true
        logedInAssert = true
        failureOnLoginAssert = true

        return self
    }

    func makeLoginWithInvalidEmailAndPassword() -> Self {
        startedAuthAssert = true
        logedInAssert = true
        invalidEmailAssert = true

        return self
    }

    func makeLoginWithInvalidPassword() -> Self {
        startedAuthAssert = true
        logedInAssert = true
        invalidPasswordAssert = true

        return self
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
        makeLoginUseCase(viewModel: MockLoginViewModel().makeLoginWithValidEmailAndPassword(), customToken: "token123")
            .execute(email: "lucas@email.com", password: "pass123")
    }

    func testLoginWithFailureReturn() {
        makeLoginUseCase(viewModel: MockLoginViewModel().makeLoginWithFailureReturn())
            .execute(email: "lucas@email.com", password: "pass123")
    }

    func testLoginWithInvalidEmailAndPassword_shouldReturnFalse() {
        makeLoginUseCase(viewModel: MockLoginViewModel().makeLoginWithInvalidEmailAndPassword())
            .execute(email: "lucas@email", password: "pass123")
    }

    func testLoginWithInvalidPassword_shouldReturnFalse() {
        makeLoginUseCase(viewModel: MockLoginViewModel().makeLoginWithInvalidPassword())
            .execute(email: "lucas@email.com", password: "pass")
    }
}
