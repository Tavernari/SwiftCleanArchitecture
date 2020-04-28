//
// Created by Victor C Tavernari on 28/04/20.
// Copyright (c) 2020 Taverna Apps. All rights reserved.
//

import Foundation

public class GitRepoRemoteConfigDataSource: GitRepoRemoteConfigDataSourceProtocol {
    public init() {}

    public func gitRepoReliability(completion: @escaping (Result<RemoteConfigData<Double>, Error>) -> Void) {
        // implementar Firebase chamada

        let configData = RemoteConfigData<Double>(isEnable: true, data: 4.0)
        completion(.success(configData))
    }
}
