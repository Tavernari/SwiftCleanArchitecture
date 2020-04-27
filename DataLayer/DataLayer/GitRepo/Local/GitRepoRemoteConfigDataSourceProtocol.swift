//
//  ConfigDataSource.swift
//  DataSource
//
//  Created by Victor C Tavernari on 24/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Domain

public protocol GitRepoRemoteConfigDataSourceProtocol {
    func gitRepoReliabilityMultiplier(completion: @escaping (Result<GitRepoReliabilityMultiplier, Error>) -> Void)
}
