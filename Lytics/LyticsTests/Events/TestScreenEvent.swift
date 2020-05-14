//
//  TestScreenEvent.swift
//  Lytics
//
//  Created by Victor C Tavernari on 12/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation
@testable import Lytics

enum TestScreenEvent: ScreenType {

    case screenWithClass(class: AnyClass?)
    case screenWithoutClass

    var classValue: AnyClass? {
        switch self {
        case let .screenWithClass(anyClass): return anyClass
        case .screenWithoutClass: return nil
        }
    }

    var name: String {
        switch self {
        case .screenWithClass: return "screenWithClass"
        case .screenWithoutClass: return "screenWithoutClass"
        }
    }
}
