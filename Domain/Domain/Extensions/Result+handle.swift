//
//  Result+handle.swift
//  Domain
//
//  Created by Victor C Tavernari on 02/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public extension Result {
    func handle() throws -> Success {
        switch self {
        case let .failure(error):
            throw error
        case let .success(data):
            return data
        }
    }
}
