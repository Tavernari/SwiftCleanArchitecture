//
//  GithubPullRequestAPIRouter.swift
//  DataLayer
//
//  Created by Victor C Tavernari on 09/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Alamofire

enum GithubAPIRouter: URLRequestConvertible {
    case listPullRequest(owner: String, repoName: String)
    case getPullRequest(owner: String, repoName: String, pullNumber: Int)

    private var path: String {
        switch self {
        case let .listPullRequest(owner, repoName):
            return "/repos/\(owner)/\(repoName)/pulls"
        case let .getPullRequest(owner, repoName, pullNumber):
            return "/repos/\(owner)/\(repoName)/pulls/\(pullNumber)"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try "\(GithubServerURL.path)\(path)".asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("token e814d42dcac8925efa8ae4704dbc028843e3aac2", forHTTPHeaderField: "Authorization")

        return urlRequest
    }
}
