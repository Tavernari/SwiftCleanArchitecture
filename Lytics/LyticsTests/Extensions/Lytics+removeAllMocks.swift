//
//  Lytics+removeAllMocks.swift
//  AnalyticsTests
//
//  Created by Victor C Tavernari on 12/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation
@testable import Analytics

extension Lytics {
    static func removeAllMocks() {
        Lytics.providers.removeAll()
    }
}
