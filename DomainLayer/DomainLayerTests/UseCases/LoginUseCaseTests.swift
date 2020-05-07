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
    let startedAuthAssert, logedInAssert, failureOnLoginAssert, invalidEmailAssert, invalidPasswordAssert: Bool

    init(startedAuth: Bool, logedIn: Bool, failureOnLogin: Bool, invalidEmail: Bool, invalidPassword: Bool) {
        startedAuthAssert = startedAuth
        logedInAssert = logedIn
        failureOnLoginAssert = failureOnLogin
        invalidEmailAssert = invalidEmail
        invalidPasswordAssert = invalidPassword
    }

    func startedAuth() {
        XCTAssert(startedAuthAssert)
    }

    func logedIn(loginModel _: LoginModel) {
        XCTAssert(logedInAssert)
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

class LoginUseCaseTests: XCTestCase {
    func testLoginWithValidEmailAndPassword_shouldReturnTrue() {
        var loginModel = LoginModel()
        loginModel.token = "token123"

        let repository = MockSignInRepository(loginResult: .success(loginModel))
        let useCase = LoginUseCase(repository: repository)
        let viewModel = MockLoginViewModel(startedAuth: true,
                                           logedIn: true,
                                           failureOnLogin: false,
                                           invalidEmail: false,
                                           invalidPassword: false)

        useCase.delegateInterfaceAdapter = viewModel
        useCase.execute(email: "lucas@email.com", password: "pass123")
    }

    func testLoginWithValidEmailAndPassword_shouldReturnFalse() {
        let loginModel = LoginModel()
        let repository = MockSignInRepository(loginResult: .success(loginModel))
        let useCase = LoginUseCase(repository: repository)
        let viewModel = MockLoginViewModel(startedAuth: true,
                                           logedIn: false,
                                           failureOnLogin: true,
                                           invalidEmail: false,
                                           invalidPassword: false)

        useCase.delegateInterfaceAdapter = viewModel

        useCase.execute(email: "lucas@email.com", password: "pass123")
    }

    func testLoginWithInvalidEmailAndPassword_shouldReturnFalse() {
        let loginModel = LoginModel()
        let repository = MockSignInRepository(loginResult: .success(loginModel))
        let useCase = LoginUseCase(repository: repository)
        let viewModel = MockLoginViewModel(startedAuth: true,
                                           logedIn: false,
                                           failureOnLogin: false,
                                           invalidEmail: true,
                                           invalidPassword: false)

        useCase.delegateInterfaceAdapter = viewModel

        useCase.execute(email: "lucas@email", password: "pass123")
    }

    func testLoginWithInvalidPassword_shouldReturnFalse() {
        let loginModel = LoginModel()
        let repository = MockSignInRepository(loginResult: .success(loginModel))
        let useCase = LoginUseCase(repository: repository)
        let viewModel = MockLoginViewModel(startedAuth: true,
                                           logedIn: false,
                                           failureOnLogin: false,
                                           invalidEmail: false,
                                           invalidPassword: true)

        useCase.delegateInterfaceAdapter = viewModel

        useCase.execute(email: "lucas@email.com", password: "pass")
    }
}
