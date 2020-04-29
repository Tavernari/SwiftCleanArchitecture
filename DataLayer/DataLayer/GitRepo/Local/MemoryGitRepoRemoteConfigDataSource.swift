//
//  MemoryConfigDataSource.swift
//  DataSource
//
//  Created by Victor C Tavernari on 24/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import DomainLayer

public class MemoryGitRepoRemoteConfigDataSource: GitRepoRemoteConfigDataSourceProtocol {
    var remoteConfigData: FlagableConfig<RepoReliabilityConfigData>
    public init(enable: Bool, multiplier: Double) {
        remoteConfigData = FlagableConfig(enable: enable, data: RepoReliabilityConfigData(multiplier: multiplier))
    }

    public func gitRepoReliability(completion: @escaping (Result<FlagableConfig<RepoReliabilityConfigData>, Error>) -> Void) {
        completion(.success(remoteConfigData))
    }
}
