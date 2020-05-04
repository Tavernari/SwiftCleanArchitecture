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

public protocol SignInRepositoryProtocol {
    func recoverPassword(email: String, completion: (Result<Bool, Error>) -> Void)
}

public protocol RecoverPasswordUseCaseInterfaceAdapter {
    func startedRecover()
    func recovered()
    func failtureOnRecover()
}

public class RecoverPasswordUseCase {
    public var delegateInterfaceAdapter: RecoverPasswordUseCaseInterfaceAdapter?

    let repository: SignInRepositoryProtocol

    init(repository: SignInRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(email: String) {
        delegateInterfaceAdapter?.startedRecover()
        repository.recoverPassword(email: email) { result in
            switch result {
            case let .success(value):

                if value {
                    delegateInterfaceAdapter?.recovered()
                } else {
                    delegateInterfaceAdapter?.failtureOnRecover()
                }
            case .failure:
                delegateInterfaceAdapter?.failtureOnRecover()
            }
        }
    }
}
