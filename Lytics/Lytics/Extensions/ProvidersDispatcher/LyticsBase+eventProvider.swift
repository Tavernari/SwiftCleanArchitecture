//
//  LyticsBase+eventDispatcher.swift
//  Analytics
//
//  Created by Victor C Tavernari on 07/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public extension LyticsBase where Self: ProvidersContainerType {

    private static var eventDispatcherProviders: [EventDispatcher] {
        return providers.filterEnabled()
    }

    static func event(event: EventType) {
        eventDispatcherProviders.forEach { $0.event(event: event) }
    }
}
