//
//  LoginDTO.swift
//  DataLayer
//
//  Created by Lucas Silveira on 07/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public struct LoginDTO: Codable {
    public let data: LoginResponseData
}

public struct LoginResponseData: Codable {
    public var token = ""
}
