//
//  APPEnvironment.swift
//  PresentationLayer
//
//  Created by Victor C Tavernari on 30/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public enum AppEnvironment: String {
    case configReliabilityEnable = "config_reliability_enable"
    case configReliabilityMultipler = "config_reliability_multiplier"
    case localhostPort
}

extension AppEnvironment {
    func string() -> String? {
        return ProcessInfo.processInfo.environment[rawValue]
    }

    func bool() -> Bool {
        return string() == "1" || string() == "true"
    }

    func double() -> Double? {
        guard let value = string() else {
            return nil
        }

        return Double(value)
    }
}
