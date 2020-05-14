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

struct RecoverPasswordUseCaseParams {
    var success, startedRecover, recovered, failureOnRecover, invalidEmail: Bool
}

class RecoverPasswordUseCaseTests: XCTestCase {
    var paramsState: RecoverPasswordUseCaseParams!

    override func setUp() {
        paramsState = RecoverPasswordUseCaseParams(success: true,
                                                   startedRecover: true,
                                                   recovered: true,
                                                   failureOnRecover: true,
                                                   invalidEmail: true)
    }

    func loadRecoverPasswordUseCase(params: RecoverPasswordUseCaseParams) -> RecoverPasswordUseCase {
        let repository = MockSignInRepository(result: .success(params.success))
        let useCase = RecoverPasswordUseCase(repository: repository)
        let viewModel = MockViewModel(startedRecover: params.startedRecover,
                                      recovered: params.recovered,
                                      failureOnRecover: params.failureOnRecover,
                                      invalidEmail: params.invalidEmail)
        useCase.delegateInterfaceAdapter = viewModel
        return useCase
    }

    func testRecoverWithValidEmail_shouldReturnTrue() {
        paramsState.failureOnRecover = false
        paramsState.invalidEmail = false

        let useCase = loadRecoverPasswordUseCase(params: paramsState)
        useCase.execute(email: "lucas@teste.com")
    }

    func testRecoverWithWrongEmail_shouldReturnFalse() {
        paramsState.success = false
        paramsState.recovered = false
        paramsState.invalidEmail = false

        let useCase = loadRecoverPasswordUseCase(params: paramsState)
        useCase.execute(email: "lucas@teste.com")
    }

    func testRecoverWithInvalidEmail_shouldReturnInvalidEmail() {
        paramsState.success = false
        paramsState.startedRecover = false
        paramsState.recovered = false
        paramsState.failureOnRecover = false

        let useCase = loadRecoverPasswordUseCase(params: paramsState)
        useCase.execute(email: "lucas.com")
    }
}
