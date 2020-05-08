//
// Created by Victor C Tavernari on 28/04/20.
// Copyright (c) 2020 Taverna Apps. All rights reserved.
//

import Firebase

class FirebaseRemoteConfig: RemoteConfig {
    static let instance = FirebaseRemoteConfig()

    private let remoteConfig: Firebase.RemoteConfig
    private init() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }

        remoteConfig = Firebase.RemoteConfig.remoteConfig()

        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
        remoteConfig.fetchAndActivate(completionHandler: nil)
    }

    subscript<T>(key: String) -> T? {
        switch T.self {
        case is String.Type:
            return remoteConfig.configValue(forKey: key).stringValue as? T
        case is Bool.Type:
            return remoteConfig.configValue(forKey: key).boolValue as? T
        case is NSNumber.Type:
            return remoteConfig.configValue(forKey: key).numberValue as? T
        case is Data.Type:
            return remoteConfig.configValue(forKey: key).dataValue as? T
        default:
            return remoteConfig.configValue(forKey: key).jsonValue as? T
        }
    }
}
