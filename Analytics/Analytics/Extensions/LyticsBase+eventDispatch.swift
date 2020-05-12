//
//  AnalyticsIdentifiable.swift
//  Analytics
//
//  Created by Victor C Tavernari on 07/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public extension LyticsBase where Self: EventType {
    func dispatch() {
        Lytics.event(event: self)
    }
}
