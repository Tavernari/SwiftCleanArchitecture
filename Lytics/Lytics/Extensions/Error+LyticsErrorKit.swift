//
//  Error+LyticsErrorKit.swift
//  Analytics
//
//  Created by Victor C Tavernari on 13/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public extension Error {
    var ly: LyticsErrorKit { LyticsErrorKit(error: self) }
}
