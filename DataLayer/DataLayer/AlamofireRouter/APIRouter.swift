//
//  APIRouter.swift
//  DataLayer
//
//  Created by Victor C Tavernari on 29/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Alamofire

enum APIRouterHttpMethod: String {
    case get
    case post
    case delete
    case put
}

protocol APIRouter: URLRequestConvertible {
    var path: String { get }
    var method: APIRouterHttpMethod { get }
}

extension APIRouter {
    func asURLRequest() throws -> URLRequest {
        let url = try "\(GithubServerURL.path)\(path)".asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
