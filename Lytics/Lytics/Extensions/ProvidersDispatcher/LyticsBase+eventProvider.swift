//
//  LyticsBase+eventDispatcher.swift
//  Analytics
//
//  Created by Victor C Tavernari on 07/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public extension LyticsBase where Self: ProvidersContainerType {
    static func event(event: EventType) {
        providers
            .filter{ $0.enable }
            .compactMap{ $0 as? EventDispatcher }
            .forEach { $0.event(event: event) }
    }
}
