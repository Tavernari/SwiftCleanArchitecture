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
    let number: Int
}

struct GithubPullRequestDetailData: Codable {
    let title: String
    let body: String
    let user: GithubPullRequestUser
    let created_at: String
    let number: Int
    let comments: Int
    let additions: Int
    let deletions: Int
    let changed_files: Int
    let commits: Int
}

struct GithubPullRequestUser: Codable {
    let login: String
    let avatar_url: String
}

