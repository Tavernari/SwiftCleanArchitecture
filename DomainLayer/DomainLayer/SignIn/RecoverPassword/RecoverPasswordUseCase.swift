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

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    public func execute(email: String) {
        guard isValidEmail(email) else {
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
