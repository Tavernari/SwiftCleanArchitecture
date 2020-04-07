//
//  ConfigDataRepository.swift
//  DataSource
//
//  Created by Victor C Tavernari on 24/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Domain

public class ConfigDataRepository: ConfigRepositoryInterface {
    private let dataSource: ConfigDataSource
    public init(dataSource: ConfigDataSource) {
        self.dataSource = dataSource
    }

    public func gitRepoReliabilityMultiplier(
        completion: @escaping (Result<GitRepoReliabilityMultiplier, Error>) -> Void
    ) {
        dataSource.gitRepoReliabilityMultiplier(completion: completion)
    }
}
