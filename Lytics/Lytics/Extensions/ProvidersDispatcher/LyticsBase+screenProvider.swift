//
//  LyticsBase+screenDispatcher.swift
//  Analytics
//
//  Created by Victor C Tavernari on 07/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public extension LyticsBase where Self: ProvidersContainerType {

    private static var screenEventDispatcherProviders: [ScreenDispatcher] {
        return providers.filterEnabled()
    }

    static func screen(screen: ScreenType) {
        screenEventDispatcherProviders.forEach { $0.screen(screen: screen) }
    }
}
