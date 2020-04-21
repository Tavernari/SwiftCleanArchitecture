//
//  Result+handleResult.swift
//  DataLayer
//
//  Created by Victor C Tavernari on 21/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

extension Result {
    func handle<ResultExpected>(
        decodeSuccess: (Success) -> ResultExpected,
        decodeError: ((Error) -> Error)? = nil,
        completion: (Result<ResultExpected, Error>) -> Void
    ) {
        switch self {
        case let .success(data):
            let decodedResult = decodeSuccess(data)
            completion(.success(decodedResult))
        case let .failure(error):
            let error = decodeError?(error) ?? error
            completion(.failure(error))
        }
    }
}
