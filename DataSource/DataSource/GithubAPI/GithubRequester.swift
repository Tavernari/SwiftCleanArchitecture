//
//  GithubRequester.swift
//  DataSource
//
//  Created by Victor C Tavernari on 04/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Alamofire

public struct GithubAPIErrorData: Codable {
    public let message: String
    public init(message: String) {
        self.message = message
    }
}

public enum GithubAPIError: LocalizedError {
    case error(data: GithubAPIErrorData?)

    public var errorDescription: String? {
        switch self {
        case let .error(data):
            return data?.message
        }
    }
}

class GithubRequester {
    private init() {}

    static func request(_ value: URLRequestConvertible) -> DataRequest {
        return AF.request(value)
            .validate(contentType: ["application/json"])
            .validate { (_, httpReponse, data) -> DataRequest.ValidationResult in
                switch httpReponse.statusCode {
                case 200 ..< 300:
                    return .success(())
                case 422:
                    let data = data ?? Data()
                    let errorData = try? JSONDecoder().decode(GithubAPIErrorData.self, from: data)
                    return .failure(GithubAPIError.error(data: errorData))
                default:
                    let error = URLError(.init(rawValue: httpReponse.statusCode))
                    return .failure(error)
                }
            }
    }
}
