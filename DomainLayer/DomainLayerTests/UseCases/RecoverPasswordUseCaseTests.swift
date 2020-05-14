//
//  RecoverPasswordUseCaseTests.swift
//  DomainLayerTests
//
//  Created by Victor C Tavernari on 04/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

@testable import DomainLayer
import XCTest

class MockViewModel: RecoverPasswordUseCaseInterfaceAdapter {
    let startedRecoverAssert, recoveredAssert, failtureOnRecoverAssert, invalidEmailAssert: Bool
    init(startedRecover: Bool, recovered: Bool, failureOnRecover: Bool, invalidEmail: Bool) {
        startedRecoverAssert = startedRecover
        recoveredAssert = recovered
        failtureOnRecoverAssert = failureOnRecover
        invalidEmailAssert = invalidEmail
    }

    func startedRecover() {
        XCTAssertTrue(startedRecoverAssert)
    }

    func recovered() {
        XCTAssertTrue(recoveredAssert)
    }

    func failureOnRecover() {
        XCTAssertTrue(failtureOnRecoverAssert)
    }

    func invalidEmail() {
        XCTAssertTrue(invalidEmailAssert)
    }
}

class RecoverPasswordUseCaseTests: XCTestCase {
    func loadRecoveryPasswordUseCase(success: Bool,
                                     startedRecover: Bool,
                                     recovered: Bool,
                                     failureOnRecover: Bool,
                                     invalidEmail: Bool) -> RecoverPasswordUseCase {
        let repository = MockSignInRepository(result: .success(success))
        let useCase = RecoverPasswordUseCase(repository: repository)
        let viewModel = MockViewModel(startedRecover: startedRecover,
                                      recovered: recovered,
                                      failureOnRecover: failureOnRecover,
                                      invalidEmail: invalidEmail)
        useCase.delegateInterfaceAdapter = viewModel
        return useCase
    }

    func testRecoverWithValidEmail_shouldReturnTrue() {
        let useCase = loadRecoveryPasswordUseCase(success: true,
                                                  startedRecover: true,
                                                  recovered: true,
                                                  failureOnRecover: false,
                                                  invalidEmail: false)
        useCase.execute(email: "lucas@teste.com")
    }

    func testRecoverWithWrongEmail_shouldReturnFalse() {
        let useCase = loadRecoveryPasswordUseCase(success: false,
                                                  startedRecover: true,
                                                  recovered: false,
                                                  failureOnRecover: true,
                                                  invalidEmail: false)
        useCase.execute(email: "lucas@teste.com")
    }

    func testRecoverWithInvalidEmail_shouldReturnInvalidEmail() {
        let useCase = loadRecoveryPasswordUseCase(success: false,
                                                  startedRecover: false,
                                                  recovered: false,
                                                  failureOnRecover: false,
                                                  invalidEmail: true)
        useCase.execute(email: "lucas.com")
    }
}
