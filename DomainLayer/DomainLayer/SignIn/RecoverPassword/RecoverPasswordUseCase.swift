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
            switch result {
            case let .success(value):

                if value {
                    self.delegateInterfaceAdapter?.recovered()
                } else {
                    self.delegateInterfaceAdapter?.failureOnRecover()
                }
            case .failure:
                self.delegateInterfaceAdapter?.failureOnRecover()
            }
        }
    }
}
