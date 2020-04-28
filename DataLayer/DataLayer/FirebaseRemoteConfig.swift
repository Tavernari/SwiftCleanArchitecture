//
// Created by Victor C Tavernari on 28/04/20.
// Copyright (c) 2020 Taverna Apps. All rights reserved.
//

import Firebase

enum FirebaseRemoteConfigError: Error {
    case failureOnProcessRemoteConfig
}

class FirebaseRemoteConfig {
    static let instance = FirebaseRemoteConfig()

    private let remoteConfig: RemoteConfig
    private init() {
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
        remoteConfig.fetch { status, error in
            print(error)
            print(status)
        }
    }

    func get<T: Decodable>(key: String) throws -> T? {
        if let remoteData = remoteConfig.value(forKey: key) {
            let jsonData = try JSONSerialization.data(withJSONObject: remoteData, options: .prettyPrinted)
            let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
            return decodedData
        }

        throw FirebaseRemoteConfigError.failureOnProcessRemoteConfig
    }
}
