//
//  MemoryConfigDataSource.swift
//  DataSource
//
//  Created by Victor C Tavernari on 24/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import DomainLayer

public class MemoryGitRepoRemoteConfigDataSource: GitRepoRemoteConfigDataSourceProtocol {
    var remoteConfigData: FlagableConfig<RepoReliabilityConfigDTO>
    public init(enable: Bool, multiplier: Double) {
        remoteConfigData = FlagableConfig(enable: enable, data: RepoReliabilityConfigDTO(multiplier: multiplier))
    }

    public func gitRepoReliability(completion: @escaping (Result<FlagableConfig<RepoReliabilityConfigDTO>, Error>) -> Void) {
        completion(.success(remoteConfigData))
    }
}
