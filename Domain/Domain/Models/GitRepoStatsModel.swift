//
//  GitRepoStatsModel.swift
//  Domain
//
//  Created by Victor C Tavernari on 24/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public struct GitRepoStatsModel: Equatable {
    public var name: String = ""
    public var closedIssues: Int = 0
    public var openedIssues: Int = 0
    public var mergedPullRequests: Int = 0
    public var proposedPullRequests: Int = 0

    public init() {}
}
