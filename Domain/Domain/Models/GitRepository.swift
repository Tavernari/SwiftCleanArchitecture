//
//  Repository.swift
//  Domain
//
//  Created by Victor C Tavernari on 02/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public struct GitRepository: Equatable {
    public var name = ""
    public var author = ""
    public var description = ""
    public var image = ""
    public var starCount = 0
    public var forkCount = 0
    public var issuesCount = 0
    public var stats = GitRepoStatsModel()
    public var isReliabilityEnabled = false
    public var reliabilityScore = 0.0

    public init() {}
}
