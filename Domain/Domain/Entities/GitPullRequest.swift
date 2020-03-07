//
//  GitPullRequests.swift
//  Domain
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public struct GitPullRequest: Equatable {
    public var author = ""
    public var title = ""
    public var description = ""
    public var image = ""
    public var date: Date?

    public init() { }
}
