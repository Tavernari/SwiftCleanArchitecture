//
//  GithubRepoAPIRouter.swift
//  DataLayer
//
//  Created by Victor C Tavernari on 09/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

enum GithubRepoAPIRouter: APIRouter {
    var baseURL: String { GithubServerURL.path }

    case search(term: String)

    var path: String {
        switch self {
        case let .search(term):
            return "/search/repositories?q=\(term)"
        }
    }

    var method: APIRouterHttpMethod {
        return .get
    }
}
