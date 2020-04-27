//
//  GitPullRequestCommitsData.swift
//  DataLayer
//
//  Created by Lucas Silveira on 23/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public struct GitPullRequestCommitsData: Codable {
    public var sha = ""
    public var commit = GitCommit()
}

public struct GitCommit: Codable {
    public var author = GitAuthor()
    public var message = ""
}

public struct GitAuthor: Codable {
    public var name = ""
    public var email = ""
    public var date = ""
}
