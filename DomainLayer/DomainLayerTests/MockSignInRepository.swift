//
//  SignInRepositoryMock.swift
//  DomainLayerTests
//
//  Created by Lucas Silveira on 07/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

@testable import DomainLayer
import XCTest

class MockSignInRepository: SignInRepositoryProtocol {
    private let result: Result<Bool, Error>
    private let loginResult: Result<LoginModel, Error>

    init(result: Result<Bool, Error>? = .success(false), loginResult: Result<LoginModel, Error>? = .success(LoginModel())) {
        self.result = result!
        self.loginResult = loginResult!
    }

    func recoverPassword(email _: String, completion: (Result<Bool, Error>) -> Void) {
        completion(result)
    }

    func login(email _: String, password _: String, completion: @escaping (Result<LoginModel, Error>) -> Void) {
        completion(loginResult)
    }
}
