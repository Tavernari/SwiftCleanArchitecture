//
// Created by Victor C Tavernari on 28/04/20.
// Copyright (c) 2020 Taverna Apps. All rights reserved.
//

import Foundation

public protocol FirebaseRemoteConfigDataSourceProtocol {
    func gitRepoReliability(completion: @escaping (Result<RemoteConfigData<Double>, Error>) -> Void)
}
