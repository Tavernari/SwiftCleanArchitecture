//
//  GithubPullRequestModels.swift
//  DataSource
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

struct GithubPullRequestData: Codable {
    let title: String
    let body: String
    let user: GithubPullRequestUser
    let created_at: String
}

struct GithubPullRequestUser: Codable {
    let login: String
    let avatar_url: String
}

