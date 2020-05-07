//
//  SignInDataSource.swift
//  DataLayer
//
//  Created by Lucas Silveira on 05/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

class SignInDataSource: SignInDataSourceProtocol {
    func recover(email: String, completion: @escaping (Result<RecoveryPasswordDTO, Error>) -> Void) {
        SignInAPIRouter.recover(email: email).request().processResponse(completion: completion)
    }

    func login(email: String, password: String, completion: @escaping (Result<LoginDTO, Error>) -> Void) {
        SignInAPIRouter.login(email: email, password: password).request().processResponse(completion: completion)
    }
}
