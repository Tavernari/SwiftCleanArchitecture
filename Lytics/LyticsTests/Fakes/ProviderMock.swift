//
//  ProviderMock.swift
//  Lytics
//
//  Created by Victor C Tavernari on 12/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation
@testable import Lytics

class ProviderMock: ProviderType {
    var enable: Bool = true
    var name: String = "ProviderMock"

    var eventValidation: ((EventType) -> Void)?
    var screenEventValidation: ((ScreenType) -> Void)?
    var userPropertiesValidation: (([String: Any]?) -> Void)?
    var userIdentificationValidation: ((_ id: String?, _ name: String?, _ email: String?) -> Void)?
    var errorValidation: ((_ error: Error, _ userInfo: [String : Any]?) -> Void )?

    init(enable: Bool = true, name: String = "ProviderMock") {
        self.enable = enable
        self.name = name
    }
}

extension ProviderMock: EventDispatcher {
    func event(event: EventType) {
        self.eventValidation?(event)
    }
}

extension ProviderMock: ScreenDispatcher {
    func screen(screen: ScreenType) {
        self.screenEventValidation?(screen)
    }
}

extension ProviderMock: UserPropertiesDispatcher {
    func user(properties: [String : Any]?) {
        self.userPropertiesValidation?(properties)
    }
}

extension ProviderMock: UserIdentificationDispatcher {
    func user(id: String?, name: String?, email: String?) {
        self.userIdentificationValidation?(id, name, email)
    }
}

extension ProviderMock: ErrorDispatcher {
    func error(_ error: Error, addtionalUserInfo userInfo: [String : Any]?) {
        self.errorValidation?(error, userInfo)
    }
}
