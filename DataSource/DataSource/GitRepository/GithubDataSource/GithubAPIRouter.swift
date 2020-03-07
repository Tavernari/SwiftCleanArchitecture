//
//  GithubAPIRouter.swift
//  DataSource
//
//  Created by Victor C Tavernari on 06/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Alamofire

enum GithubAPIRouter: URLRequestConvertible {

    struct ProductionServer {
        static let baseURL = "https://api.github.com"
    }

    case search(term: String)

    private var path: String {
        switch self {
            case .search(let term):
                return "/search/repositories?q=\(term)"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try! "\(GithubAPIRouter.ProductionServer.baseURL)\(path)".asURL()
//        let path = url.appendingPathComponent(self.path)
        let urlRequest = URLRequest(url: url)
        return urlRequest
    }
}
