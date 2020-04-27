//
//  GitPullRequestCommitsModels.swift
//  DataLayer
//
//  Created by Lucas Silveira on 23/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public struct GithubPullRequestCommitsData: Codable {
    public var sha = ""
    public var commit = Commit()
}

public struct Commit: Codable {
    public var author = Author()
    public var message = ""
}

public struct Author: Codable {
    public var name = ""
    public var email = ""
    public var date = ""
}
