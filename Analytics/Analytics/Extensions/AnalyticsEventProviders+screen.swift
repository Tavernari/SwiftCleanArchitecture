//
//  AnalyticsEventProviders+screen.swift
//  Analytics
//
//  Created by Victor C Tavernari on 07/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation
public extension AnalyticsEventProviders {
    static func screen(event: AnalyticsScreenEventType) {
        providers.forEach { provider in
            guard provider.enable else {
                return
            }

            guard let provider = provider as? AnalyticsScreenEventDispatcher else {
                return
            }

            provider.screen(event: event)

        }
    }
}
