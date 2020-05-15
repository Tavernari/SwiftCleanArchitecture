//
//  LyticsBase+userPropertiers.swift
//  Analytics
//
//  Created by Victor C Tavernari on 07/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public extension LyticsBase where Self: ProvidersContainerType {

    private static var userPropertiesDispatcherProviders: [UserPropertiesDispatcher] {
        return providers.filterEnabled()
    }

    static func user(properties: DataContainer) {
        userPropertiesDispatcherProviders.forEach { $0.user(properties: properties.data ) }
    }
}
