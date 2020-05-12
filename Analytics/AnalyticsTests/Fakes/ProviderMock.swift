//
//  ProviderMock.swift
//  AnalyticsTests
//
//  Created by Victor C Tavernari on 12/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation
@testable import Analytics

class ProviderMock: ProviderType {
    var enable: Bool = true
    var name: String = "ProviderMock"

    var eventValidation: ((EventType) -> Void)?
    var screenEventValidation: ((ScreenEventType) -> Void)?
    var userPropertiesValidation: (([String: Any]) -> Void)?
    var userIdentificationValidation: ((_ id: String?, _ name: String?, _ email: String?) -> Void)?

    init(enable: Bool = true) {
        self.enable = enable
    }
}

extension ProviderMock: EventDispatcher {
    func event(event: EventType) {
        self.eventValidation?(event)
    }
}

extension ProviderMock: ScreenEventDispatcher {
    func screen(event: ScreenEventType) {
        self.screenEventValidation?(event)
    }
}

extension ProviderMock: UserPropertiesDispatcher {
    func user(properties: [String : Any]) {
        self.userPropertiesValidation?(properties)
    }
}

extension ProviderMock: UserIdentificationDispatcher {
    func user(id: String?, name: String?, email: String?) {
        self.userIdentificationValidation?(id, name, email)
    }
}
