//
//  ReliabilityCalculator.swift
//  DataSource
//
//  Created by Victor C Tavernari on 25/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Domain

public class ReliabilityCalculatorRepository: ReliabilityMultiplierCalculatorRepository {

    public init() { }

    public func calculate(repoStats: GitRepoStatsModel, multiplier: Double) -> Double {
        let issuesScore = (Double(repoStats.closedIssues) * multiplier) + Double(repoStats.openedIssues)
        let pullRequestScore = (Double(repoStats.mergedPullRequests) * multiplier) + Double(repoStats.proposedPullRequests)
        return issuesScore + pullRequestScore
    }
}
