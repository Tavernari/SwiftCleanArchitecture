//
//  GithubAssembly.swift
//  Presentation
//
//  Created by Victor C Tavernari on 18/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Swinject
import Domain
import DataSource

class GithubAssembly: Assembly {
    func assemble(container: Container) {
        container.register(GitRepoDataSource.self) { _ in
            return GithubRepoDataSource()
        }

        container.register(GitPullRequestDataSource.self) { _ in
            return GithubPullRequestDataSource()
        }

        container.register(ConfigDataSource.self) { _ in
            let isEnable = ProcessInfo.processInfo.environment["remoteConfigReabilityEnabled"] == "true"
            let multiplier = Double(ProcessInfo.processInfo.environment["remoteConfigReabilityMultiplier"] ?? "0")!
            return MemoryConfigDataSource(enable: isEnable, multiplier: multiplier)
        }
    }
}
