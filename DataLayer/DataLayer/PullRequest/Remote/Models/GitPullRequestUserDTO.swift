//
//  GitPullRequestUser.swift
//  DataSource
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

public struct GitPullRequestUserDTO: Codable {
    public var login: String = ""
    public var avatar_url: String = ""
    public init() {}
}
