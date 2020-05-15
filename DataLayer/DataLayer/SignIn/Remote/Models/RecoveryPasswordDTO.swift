//
//  RecoveryPasswordDTO.swift
//  DataLayer
//
//  Created by Lucas Silveira on 05/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public struct RecoveryPasswordDTO: Codable {
    public let data: RecoveryPasswordResponseData
}

public struct RecoveryPasswordResponseData: Codable {
    public var recovered = false
}
