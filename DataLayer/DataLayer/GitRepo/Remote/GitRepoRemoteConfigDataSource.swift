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
                let data: FlagableConfig<RepoReliabilityConfigData> = try FirebaseRemoteConfig.instance.data(key: "repoReliability").decode()
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
