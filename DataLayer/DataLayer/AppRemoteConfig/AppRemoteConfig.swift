//
//  AppRemoteConfig.swift
//  DataLayer
//
//  Created by Victor C Tavernari on 04/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public protocol RemoteConfig {
    subscript<T>(_: String) -> T? { get }
}

public protocol RemoteConfigMaking {
    func make() -> RemoteConfig
}

class AppRemoteConfig: RemoteConfig {
    private let remoteConfig: RemoteConfig
    init(remoteConfig: RemoteConfig) {
        self.remoteConfig = remoteConfig
    }

    subscript<T>(key: String) -> T? {
        return remoteConfig[key]
    }
}
