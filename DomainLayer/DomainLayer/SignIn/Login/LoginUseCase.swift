//
//  LoginUseCase.swift
//  DomainLayer
//
//  Created by Lucas Silveira on 05/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public protocol LoginUseCaseInterfaceAdapter {
    func startedAuth()
    func logedIn(loginModel: LoginModel)
    func failureOnLogin()
    func invalidEmail()
    func invalidPassword()
}

public class LoginUseCase {
    public var delegateInterfaceAdapter: LoginUseCaseInterfaceAdapter?
    let repository: SignInRepositoryProtocol

    init(repository: SignInRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(email: String, password: String) {
        guard email.isValidEmail() else {
            delegateInterfaceAdapter?.invalidEmail()
            return
        }

        guard password.isValidPassword() else {
            delegateInterfaceAdapter?.invalidPassword()
            return
        }

        delegateInterfaceAdapter?.startedAuth()

        repository.login(email: email, password: password) { result in
            switch result {
            case let .success(loginModel):
                if !loginModel.token.isEmpty {
                    self.delegateInterfaceAdapter?.logedIn(loginModel: loginModel)
                } else {
                    self.delegateInterfaceAdapter?.failureOnLogin()
                }
            case .failure:
                self.delegateInterfaceAdapter?.failureOnLogin()
            }
        }
    }
}
