//
//  SignInRepositoryProtocol.swift
//  DomainLayer
//
//  Created by Lucas Silveira on 07/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public protocol SignInRepositoryProtocol {
    func recoverPassword(email: String, completion: @escaping (Result<Bool, Error>) -> Void)
    func login(email: String, password: String, completion: @escaping (Result<LoginModel, Error>) -> Void)
}
