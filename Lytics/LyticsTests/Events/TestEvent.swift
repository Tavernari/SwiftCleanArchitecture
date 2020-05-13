//
//  TestEvent.swift
//  Lytics
//
//  Created by Victor C Tavernari on 12/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation
@testable import Lytics

enum TestEvent: EventType {

    case withoutData
    case withData(data: String)

    var name: String {
        switch self {
        case .withData: return "withData"
        case .withoutData: return "withoutData"
        }
    }

    var data: [String : Any]? {
        switch self {
        case let .withData(data): return ["data": data]
        case .withoutData: return nil
        }
    }
}
