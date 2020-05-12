//
//  AnalyticsRecognizable.swift
//  Analytics
//
//  Created by Victor C Tavernari on 12/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public protocol AnalyticsRecognizable {
    var emailValue: String? { get }
    var nameValue: String? { get }
    var idValue: String? { get }
}
