//
//  ReliabilityMultiplierCalculatorRepository.swift
//  Domain
//
//  Created by Victor C Tavernari on 25/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public protocol ReliabilityMultiplierCalculatorRepository {
    func calculate(repoStats: GitRepoStatsModel, multiplier: Double) -> Double
}
