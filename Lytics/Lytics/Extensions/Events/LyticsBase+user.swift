//
//  LyticsBase.swift
//  Analytics
//
//  Created by Victor C Tavernari on 12/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public extension LyticsBase where Self: UserPropertiesType {
    func dispatch() {
        guard self.emailValue == nil && self.idValue == nil && self.nameValue == nil else {
            Lytics.user(recognizable: self)
            return
        }

        Lytics.user(properties: self)
    }
}
