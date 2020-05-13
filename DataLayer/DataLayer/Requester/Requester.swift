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

    func request<DecodedType: Error>(decodeError: @escaping (Data?) -> DecodedType?) -> DataRequest {
        return Requester.request(self, decodeError: decodeError)
    }
}

class Requester {
    static func request(_ value: URLRequestConvertible) -> DataRequest {
        return AF.request(value)
            .validate(statusCode: 200 ..< 300)
            .validate(contentType: ["application/json"])
    }

    private static func validate<DecodedType: Error>(
        decodeError: @escaping (Data?) -> DecodedType?,
        urlRequest _: URLRequest?,
        httpReponse: HTTPURLResponse,
        data: Data?
    ) -> DataRequest.ValidationResult {
        switch httpReponse.statusCode {
        case 200 ..< 300:
            return .success(())
        default:
            if let errorDecoded = decodeError(data) {
                return .failure(errorDecoded)
            }

            let error = URLError(.init(rawValue: httpReponse.statusCode))
            return .failure(error)
        }
    }

    static func request<DecodedType: Error>(
        _ value: URLRequestConvertible,
        decodeError: @escaping (Data?) -> DecodedType?
    ) -> DataRequest {
        return AF.request(value)
            .validate(contentType: ["application/json"])
            .validate { (urlRequest, httpReponse, data) -> DataRequest.ValidationResult in
                self.validate(decodeError: decodeError, urlRequest: urlRequest, httpReponse: httpReponse, data: data)
            }
    }
}
