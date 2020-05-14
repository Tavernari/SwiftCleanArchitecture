//
//  RecoverPasswordUseCase.swift
//  DomainLayer
//
//  Created by Victor C Tavernari on 04/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public enum RecoverPasswordUseCaseError: Error, Equatable {
    case defaultError
}

public protocol RecoverPasswordUseCaseInterfaceAdapter {
    func startedRecover()
    func recovered()
    func failureOnRecover()
    func invalidEmail()
}

public class RecoverPasswordUseCase {
    public var delegateInterfaceAdapter: RecoverPasswordUseCaseInterfaceAdapter?

    let repository: SignInRepositoryProtocol

    init(repository: SignInRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(email: String) {
        guard email.isValidEmail() else {
            delegateInterfaceAdapter?.invalidEmail()
            return
        }

        delegateInterfaceAdapter?.startedRecover()

        repository.recoverPassword(email: email) { result in
            guard let value = try? result.handle(), value == true else {
                self.delegateInterfaceAdapter?.failureOnRecover()
                return
            }

            self.delegateInterfaceAdapter?.recovered()
        }
    }
}
