//
// Created by Victor C Tavernari on 27/04/20.
// Copyright (c) 2020 Taverna Apps. All rights reserved.
//

import Foundation

public struct GitPullRequestData: Codable {
    public var title: String = ""
    public var body: String = ""
    public var user: GitPullRequestUser = .init()
    public var created_at: String = ""
    public var updated_at: String = ""
    public var number: Int = 0
    public init() {}
}
