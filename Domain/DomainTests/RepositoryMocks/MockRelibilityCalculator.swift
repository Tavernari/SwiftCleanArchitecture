//
//  MockRelibilityCalculator.swift
//  DomainTests
//
//  Created by Victor C Tavernari on 31/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Domain

class MockRelibilityCalculator: ReliabilityMultiplierCalculatorRepository {

    let returnValue: Double
    init(returnValue: Double = 1.0) {
        self.returnValue = returnValue
    }

    func calculate(repoStats: GitRepoStatsModel, multiplier: Double) -> Double {
        return returnValue
    }
}
