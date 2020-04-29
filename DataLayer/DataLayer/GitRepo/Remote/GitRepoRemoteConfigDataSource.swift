//
// Created by Victor C Tavernari on 28/04/20.
// Copyright (c) 2020 Taverna Apps. All rights reserved.
//

import Foundation

public class GitRepoRemoteConfigDataSource: GitRepoRemoteConfigDataSourceProtocol {
    public init() {}

    public func gitRepoReliability(
        completion: @escaping (Result<RemoteConfigData<RepoReliabilityConfigData>, Error>) -> Void
    ) {
        FirebaseRemoteConfig.instance.initialize { _ in
            DispatchQueue.main.async {
                do {
                    let data: RemoteConfigData<RepoReliabilityConfigData> = try FirebaseRemoteConfig.instance.get(key: "repoReliability")!
                    completion(.success(data))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}
