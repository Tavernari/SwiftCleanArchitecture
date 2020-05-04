//
//  AppRemoteConfigMaking.swift
//  DataLayer
//
//  Created by Victor C Tavernari on 04/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public enum AppRemoteConfigMaking: RemoteConfigMaking {
    case configDefault

    public func make() -> RemoteConfig {
        return AppRemoteConfig(remoteConfig: FirebaseRemoteConfig.instance)
    }
}
