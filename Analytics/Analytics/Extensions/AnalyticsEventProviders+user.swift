//
//  AnalyticsEventProviders+user.swift
//  Analytics
//
//  Created by Victor C Tavernari on 07/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public extension AnalyticsEventProviders {
    static func user(properties: [String: Any]) {
        providers.forEach { provider in
            guard provider.enable else {
                return
            }

            guard let provider = provider as? AnalyticsUserPropertiesDispatcher else {
                return
            }

            provider.user(properties: properties)

        }
    }

    static func user(id: String?, name: String?, email: String?) {
        providers.forEach { provider in
            guard provider.enable else {
                return
            }

            guard let provider = provider as? AnalyticsUserIdentificationDispatcher else {
                return
            }

            provider.user(id: id, name: name, email: email)

        }
    }
}
