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

class LoginUseCaseTests: XCTestCase {
    func loadLoginUseCase(customToken: String? = "",
                          startedAuth: Bool,
                          logedIn: Bool,
                          failureOnLogin: Bool,
                          invalidEmail: Bool,
                          invalidPassword: Bool) -> LoginUseCase {
        var loginModel = LoginModel()
        loginModel.token = customToken!

        let repository = MockSignInRepository(loginResult: .success(loginModel))
        let useCase = LoginUseCase(repository: repository)
        let viewModel = MockLoginViewModel(startedAuth: startedAuth,
                                           logedIn: logedIn,
                                           failureOnLogin: failureOnLogin,
                                           invalidEmail: invalidEmail,
                                           invalidPassword: invalidPassword)

        useCase.delegateInterfaceAdapter = viewModel

        return useCase
    }

    func testLoginWithValidEmailAndPassword_shouldReturnTrue() {
        let useCase = loadLoginUseCase(customToken: "token123",
                                       startedAuth: true,
                                       logedIn: true,
                                       failureOnLogin: false,
                                       invalidEmail: false,
                                       invalidPassword: false)
        useCase.execute(email: "lucas@email.com", password: "pass123")
    }

    func testLoginWithValidEmailAndPassword_shouldReturnFalse() {
        let useCase = loadLoginUseCase(startedAuth: true,
                                       logedIn: false,
                                       failureOnLogin: true,
                                       invalidEmail: false,
                                       invalidPassword: false)
        useCase.execute(email: "lucas@email.com", password: "pass123")
    }

    func testLoginWithInvalidEmailAndPassword_shouldReturnFalse() {
        let useCase = loadLoginUseCase(customToken: "token123",
                                       startedAuth: true,
                                       logedIn: false,
                                       failureOnLogin: false,
                                       invalidEmail: true,
                                       invalidPassword: false)
        useCase.execute(email: "lucas@email", password: "pass123")
    }

    func testLoginWithInvalidPassword_shouldReturnFalse() {
        let useCase = loadLoginUseCase(customToken: "token123",
                                       startedAuth: true,
                                       logedIn: false,
                                       failureOnLogin: false,
                                       invalidEmail: false,
                                       invalidPassword: true)
        useCase.execute(email: "lucas@email.com", password: "pass")
    }
}
