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
}
