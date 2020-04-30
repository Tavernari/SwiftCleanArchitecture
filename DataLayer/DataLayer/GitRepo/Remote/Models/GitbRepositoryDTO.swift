//
// Created by Victor C Tavernari on 27/04/20.
// Copyright (c) 2020 Taverna Apps. All rights reserved.
//

import Foundation

public struct GitbRepositoryDTO: Codable {
    public var name: String = ""
    public var description: String? = ""
    public var stargazers_count: Int = 0
    public var forks_count: Int = 0
    public var open_issues_count: Int = 0
    public var owner: GitRepositoryOwnerDTO = .init()
    public init() {}
}
