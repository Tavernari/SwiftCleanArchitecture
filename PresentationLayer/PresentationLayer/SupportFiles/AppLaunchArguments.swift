//
//  AppLaunchArguments.swift
//  PresentationLayer
//
//  Created by Victor C Tavernari on 30/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public enum AppLaunchArguments: String {
    case uiTesting = "ui-testing"
}

extension AppLaunchArguments {
    var exist: Bool { ProcessInfo.processInfo.arguments.contains(rawValue) }
}
