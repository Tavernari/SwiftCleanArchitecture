//
// Created by Victor C Tavernari on 28/04/20.
// Copyright (c) 2020 Taverna Apps. All rights reserved.
//

import Foundation

public protocol GitRepoRemoteConfigDataSourceProtocol {
    func gitRepoReliability(completion: @escaping (Result<FlagableConfig<RepoReliabilityConfigDTO>, Error>) -> Void)
}
