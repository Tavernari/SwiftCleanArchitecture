//
// Created by Victor C Tavernari on 27/04/20.
// Copyright (c) 2020 Taverna Apps. All rights reserved.
//

import Foundation

public struct GitPullRequestDetailDTO: Codable {
    public var title: String = ""
    public var body: String = ""
    public var user: GitPullRequestUserDTO = .init()
    public var created_at: String = ""
    public var updated_at: String = ""
    public var number: Int = 0
    public var comments: Int = 0
    public var additions: Int = 0
    public var deletions: Int = 0
    public var changed_files: Int = 0
    public var commits: Int = 0
    public init() {}
}
