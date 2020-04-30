//
//  UITestRemoteConfigAssembly.swift
//  PresentationLayer
//
//  Created by Victor C Tavernari on 30/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import DataLayer
import DomainLayer
import Swinject

class FakeGitRepoRemoteConfigDataSource: GitRepoRemoteConfigDataSourceProtocol {
    func gitRepoReliability(completion: @escaping (Result<FlagableConfig<RepoReliabilityConfigDTO>, Error>) -> Void) {
        let multiplier = AppEnvironment.configReliabilityMultipler.double() ?? 0.0
        let enable = AppEnvironment.configReliabilityEnable.bool()
        let repoReliabilityConfigDTO = RepoReliabilityConfigDTO(multiplier: multiplier)
        let flagableConfig = FlagableConfig<RepoReliabilityConfigDTO>(enable: enable, data: repoReliabilityConfigDTO)
        completion(.success(flagableConfig))
    }
}

class UITestRemoteConfigAssembly: Assembly {
    func assemble(container: Container) {
        container.register(GitRepoRemoteConfigDataSourceProtocol.self) { _ in
            FakeGitRepoRemoteConfigDataSource()
        }
    }
}
