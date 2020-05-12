//
//  AnalyticsEventProviders+user.swift
//  Analytics
//
//  Created by Victor C Tavernari on 07/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public extension AnalyticsEventProviders {
    static func user(properties: AnalyticsData) {
        providers.forEach { provider in
            guard provider.enable else {
                return
            }

            guard let provider = provider as? AnalyticsUserPropertiesDispatcher else {
                return
            }

            provider.user(properties: properties.data ?? [:])

        }
    }

    static func user(recognizable: AnalyticsRecognizable) {
        providers.forEach { provider in
            guard provider.enable else {
                return
            }

            guard let provider = provider as? AnalyticsUserIdentificationDispatcher else {
                return
            }

            let id = recognizable.idValue
            let name = recognizable.nameValue
            let email = recognizable.emailValue
            provider.user(id: id, name: name, email: email)

        }
    }
}
