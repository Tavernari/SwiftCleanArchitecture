//
//  TestUserProperties.swift
//  AnalyticsTests
//
//  Created by Victor C Tavernari on 12/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation
@testable import Analytics

enum TestUserProperties: UserPropertiesType {

    case identify(id: String?, name: String?, email: String?)
    case isVip(Bool)
    case totalCoin(Int)

    var nameValue: String? {
        switch self {
        case let .identify(_, name, _): return name
        default: return nil
        }
    }

    var emailValue: String? {
        switch self {
        case let .identify(_, _, email): return email
        default: return nil
        }
    }

    var idValue: String? {
        switch self {
        case let .identify(id, _, _): return id
        default: return nil
        }
    }

    var data: [String : Any]? {
        switch self {
        case let .isVip(value): return ["isVip":value]
        case let .totalCoin(value): return ["totalCoin":value]
        default: return nil
        }
    }
}
