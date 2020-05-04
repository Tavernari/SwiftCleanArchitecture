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
    let startedRecoverAssert, recoveredAssert, failtureOnRecoverAssert: Bool
    init(startedRecover: Bool, recovered: Bool, failtureOnRecover: Bool) {
        startedRecoverAssert = startedRecover
        recoveredAssert = recovered
        failtureOnRecoverAssert = failtureOnRecover
    }

    func startedRecover() {
        XCTAssertTrue(startedRecoverAssert)
    }

    func recovered() {
        XCTAssertTrue(recoveredAssert)
    }

    func failtureOnRecover() {
        XCTAssertTrue(failtureOnRecoverAssert)
    }
}

class RecoverPasswordUseCaseTests: XCTestCase {
    func testRecoverWithValidEmail_shouldReturnTrue() {
        let repository = MockSignInRepository(result: .success(true))
        let useCase = RecoverPasswordUseCase(repository: repository)
        let viewModel = MockViewModel(startedRecover: true, recovered: true, failtureOnRecover: false)
        useCase.delegateInterfaceAdapter = viewModel

        useCase.execute(email: "lucas@teste.com")
    }

    func testRecoverWithWrongEmail_shouldReturnFalse() {
        let repository = MockSignInRepository(result: .success(false))
        let useCase = RecoverPasswordUseCase(repository: repository)
        let viewModel = MockViewModel(startedRecover: true, recovered: false, failtureOnRecover: true)
        useCase.delegateInterfaceAdapter = viewModel

        useCase.execute(email: "lucas@teste.com")
    }
}
