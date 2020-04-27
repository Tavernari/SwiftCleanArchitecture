//
//  GithubRepoAPIRouter.swift
//  DataLayer
//
//  Created by Victor C Tavernari on 09/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Alamofire

enum GithubRepoAPIRouter: URLRequestConvertible {
    case search(term: String)

    private var path: String {
        switch self {
        case let .search(term):
            return "/search/repositories?q=\(term)"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try "\(GithubServerURL.path)\(path)".asURL()
        let urlRequest = URLRequest(url: url)
        return urlRequest
    }
}
