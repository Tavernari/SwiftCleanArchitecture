//
//  GithubPullRequestModels.swift
//  DataSource
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

public struct GithubPullRequestData: Codable {
    public var title: String = ""
    public var body: String = ""
    public var user: GithubPullRequestUser = .init()
    public var created_at: String = ""
    public var updated_at: String = ""
    public var number: Int = 0
    public init() {}
}

public struct GithubPullRequestDetailData: Codable {
    public var title: String = ""
    public var body: String = ""
    public var user: GithubPullRequestUser = .init()
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

public struct GithubPullRequestUser: Codable {
    public var login: String = ""
    public var avatar_url: String = ""
    public init() {}
}
