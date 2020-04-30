//
// Created by Victor C Tavernari on 28/04/20.
// Copyright (c) 2020 Taverna Apps. All rights reserved.
//

import Firebase

enum FirebaseRemoteConfigError: Error {
    case keyDoesNotReturnValidReponse
}

class FirebaseRemoteConfig {
    static let instance = FirebaseRemoteConfig()

    private let remoteConfig: RemoteConfig
    private init() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }

        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
    }

    func initialize(completion: @escaping (Result<Bool, Error>) -> Void) {
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
        remoteConfig.fetch { status, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(error!))
                }
                return
            }

            if status == .success {
                self.remoteConfig.activate(completionHandler: { _ in
                    DispatchQueue.main.async {
                        completion(.success(true))
                    }
                })
            } else {
                completion(.success(false))
            }
        }
    }

    func data(key: String) throws -> Data {
        return remoteConfig.configValue(forKey: key).dataValue
    }

    func string(key: String) -> String? {
        return remoteConfig.configValue(forKey: key).stringValue
    }

    func json(key: String) -> Any? {
        return remoteConfig.configValue(forKey: key).jsonValue
    }
}
