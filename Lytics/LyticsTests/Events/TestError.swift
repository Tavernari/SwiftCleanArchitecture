//
//  TestError.swift
//  Lytics
//
//  Created by Victor C Tavernari on 13/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation
@testable import Lytics

enum TestError: LyticsErrorType {
    var data: [String : Any]? {
        switch self {
        case let .withUserInfo(data): return data
        default: return nil
        }
    }

    case withoutUserInfo
    case withUserInfo(data: [String: Any])
}
