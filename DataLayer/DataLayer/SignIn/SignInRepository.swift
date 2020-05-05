//
//  File.swift
//  DataLayer
//
//  Created by Lucas Silveira on 05/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import DomainLayer

class SignInRepository: SignInRepositoryProtocol {
    let signInDataSource: SignInDataSourceProtocol

    init(signInDataSource: SignInDataSourceProtocol) {
        self.signInDataSource = signInDataSource
    }

    func recoverPassword(email: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        signInDataSource.recover(email: email) { result in
            switch result {
            case let .success(value):
                completion(.success(value.data.recovered))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
