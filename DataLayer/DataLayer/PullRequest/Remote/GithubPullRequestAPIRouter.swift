//
//  GithubPullRequestAPIRouter.swift
//  DataLayer
//
//  Created by Victor C Tavernari on 09/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Alamofire

enum GithubAPIRouter: APIRouter {
    case listPullRequest(owner: String, repoName: String)
    case getPullRequest(owner: String, repoName: String, pullNumber: Int)
    case commits(owner: String, repoName: String)

    var path: String {
        switch self {
        case let .listPullRequest(owner, repoName):
            return "/repos/\(owner)/\(repoName)/pulls"
        case let .getPullRequest(owner, repoName, pullNumber):
            return "/repos/\(owner)/\(repoName)/pulls/\(pullNumber)"
        case let .commits(owner, repoName):
            return "/repos/\(owner)/\(repoName)/commits"
        }
    }

    var method: APIRouterHttpMethod {
        return .get
    }
}
