//
//  Requester.swift
//  DataSource
//
//  Created by Victor C Tavernari on 04/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Alamofire

struct GenericError: LocalizedError {
    private let message: String
    public init(message: String) {
        self.message = message
    }

    var errorDescription: String? { message }
}

extension URLRequestConvertible {
    func request() -> DataRequest {
        return Requester.request(self)
    }

    func request(decodeError: @escaping (Data?) -> String?) -> DataRequest {
        return Requester.request(self, decodeError: decodeError)
    }
}

class Requester {
    static func request(_ value: URLRequestConvertible) -> DataRequest {
        return AF.request(value)
            .validate(statusCode: 200 ..< 300)
            .validate(contentType: ["application/json"])
    }

    static func request(
        _ value: URLRequestConvertible,
        decodeError: @escaping (Data?) -> String?
    ) -> DataRequest {
        return AF.request(value)
            .validate(contentType: ["application/json"])
            .validate { (_, httpReponse, data) -> DataRequest.ValidationResult in
                switch httpReponse.statusCode {
                case 200 ..< 300:
                    return .success(())
                default:
                    if let message = decodeError(data) {
                        return .failure(GenericError(message: message))
                    }

                    let error = URLError(.init(rawValue: httpReponse.statusCode))
                    return .failure(error)
                }
            }
    }
}
