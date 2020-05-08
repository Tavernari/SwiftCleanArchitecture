//
// Created by Victor C Tavernari on 28/04/20.
// Copyright (c) 2020 Taverna Apps. All rights reserved.
//

import Foundation

public class GitRepoRemoteConfigDataSource: GitRepoRemoteConfigDataSourceProtocol {
    let remoteConfig: RemoteConfig

    public init(appRemoteMaking: RemoteConfigMaking = AppRemoteConfigMaking.configDefault) {
        remoteConfig = appRemoteMaking.make()
    }

    public func gitRepoReliability(
        completion: @escaping (Result<FlagableConfig<RepoReliabilityConfigDTO>, Error>) -> Void
    ) {
        do {
            let data: Data! = remoteConfig["reliability_factor_ios"]
            let decodedData: FlagableConfig<RepoReliabilityConfigDTO> = try data.decode()
            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }
}
