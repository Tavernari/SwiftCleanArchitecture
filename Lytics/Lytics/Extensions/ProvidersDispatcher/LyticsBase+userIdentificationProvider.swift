//
// Created by Victor C Tavernari on 12/05/20.
// Copyright (c) 2020 Taverna Apps. All rights reserved.
//

import Foundation

public extension LyticsBase where Self: ProvidersContainerType {

    private static var userIdentificationDispatcherProviders: [UserIdentificationDispatcher] {
        return providers.filterEnabled()
    }

    static func user(recognizable: Recognizable) {
        userIdentificationDispatcherProviders.forEach { provider in
            let id = recognizable.idValue
            let name = recognizable.nameValue
            let email = recognizable.emailValue
            provider.user(id: id, name: name, email: email)
        }
    }
}
