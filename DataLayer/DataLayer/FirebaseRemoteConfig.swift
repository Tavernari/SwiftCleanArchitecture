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
                print(error)
                completion(.failure(error!))
                return
            }

            if status == .success {
                print("Config fetched!")
                self.remoteConfig.activate(completionHandler: { _ in
                    completion(.success(true))
                })
            }
        }
    }

    func get<T: Decodable>(key: String) throws -> T? {
        guard let jsonValue = remoteConfig.configValue(forKey: key).jsonValue else {
            throw FirebaseRemoteConfigError.keyDoesNotReturnValidReponse
        }
        print(jsonValue)
        let jsonData = try JSONSerialization.data(withJSONObject: jsonValue, options: .prettyPrinted)
        let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
        return decodedData
    }
}
