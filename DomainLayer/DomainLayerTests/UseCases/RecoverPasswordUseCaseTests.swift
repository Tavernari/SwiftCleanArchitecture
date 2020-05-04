//
//  RecoverPasswordUseCaseTests.swift
//  DomainLayerTests
//
//  Created by Victor C Tavernari on 04/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

@testable import DomainLayer
import XCTest

class MockSignInRepository: SignInRepositoryProtocol {
    private let result: Result<Bool, Error>
    init(result: Result<Bool, Error>) {
        self.result = result
    }

    func recoverPassword(email _: String, completion: (Result<Bool, Error>) -> Void) {
        completion(result)
    }
}

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
    func testRecoverWithValidEmail_shouldReturnTrue() {
        let repository = MockSignInRepository(result: .success(true))
        let useCase = RecoverPasswordUseCase(repository: repository)
        let viewModel = MockViewModel(startedRecover: true, recovered: true, failureOnRecover: false, invalidEmail: false)
        useCase.delegateInterfaceAdapter = viewModel

        useCase.execute(email: "lucas@teste.com")
    }

    func testRecoverWithWrongEmail_shouldReturnFalse() {
        let repository = MockSignInRepository(result: .success(false))
        let useCase = RecoverPasswordUseCase(repository: repository)
        let viewModel = MockViewModel(startedRecover: true, recovered: false, failureOnRecover: true, invalidEmail: false)
        useCase.delegateInterfaceAdapter = viewModel

        useCase.execute(email: "lucas@teste.com")
    }

    func testRecoverWithInvalidEmail_shouldReturnInvalidEmail() {
        let repository = MockSignInRepository(result: .success(false))
        let useCase = RecoverPasswordUseCase(repository: repository)
        let viewModel = MockViewModel(startedRecover: false, recovered: false, failureOnRecover: false, invalidEmail: true)
        useCase.delegateInterfaceAdapter = viewModel

        useCase.execute(email: "lucas.com")
    }
}
