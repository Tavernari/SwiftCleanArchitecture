//
//  ConfigRepository.swift
//  Domain
//
//  Created by Victor C Tavernari on 24/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
public protocol ConfigRepositoryInterface {
    func gitRepoReliabilityMultiplier(completion: @escaping (Result<GitRepoReliabilityMultiplier, Error>) -> Void)
}
