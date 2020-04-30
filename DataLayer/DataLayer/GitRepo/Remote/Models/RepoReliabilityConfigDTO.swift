//
// Created by Victor C Tavernari on 29/04/20.
// Copyright (c) 2020 Taverna Apps. All rights reserved.
//

import Foundation

public struct RepoReliabilityConfigDTO: Codable {
    public let multiplier: Double

    public init(multiplier: Double) {
        self.multiplier = multiplier
    }
}
