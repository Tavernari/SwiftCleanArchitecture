//
//  MemoryConfigDataSource.swift
//  DataSource
//
//  Created by Victor C Tavernari on 24/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import DomainLayer

public class MemoryGitRepoRemoteConfigDataSource: GitRepoRemoteConfigDataSourceProtocol {
    var remoteConfigData: RemoteConfigData<Double>
    public init(enable: Bool, multiplier: Double) {
        remoteConfigData = RemoteConfigData<Double>(isEnable: enable, data: multiplier)
    }

    public func gitRepoReliability(completion: @escaping (Result<RemoteConfigData<Double>, Error>) -> Void) {
        completion(.success(remoteConfigData))
    }
}
