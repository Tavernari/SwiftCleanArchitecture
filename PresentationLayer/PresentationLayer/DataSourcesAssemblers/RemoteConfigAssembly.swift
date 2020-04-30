//
//  RemoteConfigAssembly.swift
//  PresentationLayer
//
//  Created by Victor C Tavernari on 30/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import DataLayer
import DomainLayer
import Swinject

class RemoteConfigAssembly: Assembly {
    func assemble(container: Container) {
        container.register(GitRepoRemoteConfigDataSourceProtocol.self) { _ in
            GitRepoRemoteConfigDataSource()
        }
    }
}
