//
// Created by Victor C Tavernari on 28/04/20.
// Copyright (c) 2020 Taverna Apps. All rights reserved.
//

import Foundation

public class GitRepoRemoteConfigDataSource: GitRepoRemoteConfigDataSourceProtocol {
    public init() {}

    public func gitRepoReliability(
        completion: @escaping (Result<FlagableConfig<RepoReliabilityConfigData>, Error>) -> Void
    ) {
        FirebaseRemoteConfig.instance.initialize { _ in
            do {
                let data = try FirebaseRemoteConfig.instance.data(key: "repoReliability")
                let flagableConfig: FlagableConfig<RepoReliabilityConfigData> = try data.decode()
                completion(.success(flagableConfig))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
