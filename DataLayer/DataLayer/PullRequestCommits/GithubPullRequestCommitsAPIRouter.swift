//
//  GithubPullRequestCommitsAPIRouter.swift
//  DataLayer
//
//  Created by Lucas Silveira on 23/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Alamofire

enum GithubPullRequestCommitsAPIRouter: URLRequestConvertible {
    case listPullRequestCommits(owner: String, repoName: String)

    private var path: String {
        switch self {
        case let .listPullRequestCommits(owner, repoName):
            return "/repos/\(owner)/\(repoName)/commits"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try "\(GithubServerURL.path)\(path)".asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("token e814d42dcac8925efa8ae4704dbc028843e3aac2", forHTTPHeaderField: "Authorization")

        return urlRequest
    }
}
