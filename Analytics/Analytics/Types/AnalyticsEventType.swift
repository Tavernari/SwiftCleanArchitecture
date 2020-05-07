//
//  AnalyticsEventType.swift
//  Analytics
//
//  Created by Victor C Tavernari on 07/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public typealias AnalyticsEventType = AnalyticsIdentifiable & AnalyticsData
public extension AnalyticsEventProviders {
    static func event(event: AnalyticsEventType) {
        providers.forEach { provider in
            guard provider.enable else {
                return
            }

            guard let provider = provider as? AnalyticsEventDispatcher else {
                return
            }

            provider.event(event: event)

        }
    }
}
