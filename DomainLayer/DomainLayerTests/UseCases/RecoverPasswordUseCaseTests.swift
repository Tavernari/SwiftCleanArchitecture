//
//  RecoverPasswordUseCaseTests.swift
//  DomainLayerTests
//
//  Created by Victor C Tavernari on 04/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

@testable import DomainLayer
import XCTest

class MockFalseSiginRepository: SignInRepositoryProtocol {
    func recoverPassword(email _: String, completion: (Result<Bool, Error>) -> Void) {
        completion(.success(false))
    }
}

class MockTrueSiginRepository: SignInRepositoryProtocol {
    func recoverPassword(email _: String, completion: (Result<Bool, Error>) -> Void) {
        completion(.success(true))
    }
}

class MockStartedPresenterAdapter: RecoverPasswordUseCaseInterfaceAdapter {
    func startedRecover() {
        XCTAssertTrue(true)
    }

    func recovered() {}

    func failtureOnRecover() {}
}

class MockFailurePresenterAdapter: RecoverPasswordUseCaseInterfaceAdapter {
    func startedRecover() {
        XCTAssertTrue(true)
    }

    func recovered() {
        XCTFail()
    }

    func failtureOnRecover() {
        XCTAssertTrue(true)
    }
}

class MockSuccessPresenterAdapter: RecoverPasswordUseCaseInterfaceAdapter {
    func startedRecover() {
        XCTAssertTrue(true)
    }

    func recovered() {
        XCTAssertTrue(true)
    }

    func failtureOnRecover() {
        XCTFail()
    }
}

class RecoverPasswordUseCaseTests: XCTestCase {
    func testRecoverWithValidEmail_shouldReturnTrue() {
        let repository = MockTrueSiginRepository()
        let useCase = RecoverPasswordUseCase(repository: repository)
        useCase.delegateInterfaceAdapter = MockSuccessPresenterAdapter()

        useCase.execute(email: "lucas@teste.com")
    }

    func testRecoverWithWrongEmail_shouldReturnFalse() {
        let repository = MockFalseSiginRepository()
        let useCase = RecoverPasswordUseCase(repository: repository)
        useCase.delegateInterfaceAdapter = MockFailurePresenterAdapter()

        useCase.execute(email: "lucas@teste.com")
    }

    func testRecoverPassword_shouldNotifyIfStartedProcess() {
        let repository = MockFalseSiginRepository()
        let useCase = RecoverPasswordUseCase(repository: repository)
        useCase.delegateInterfaceAdapter = MockStartedPresenterAdapter()

        useCase.execute(email: "lucas@teste.com")
    }
}
