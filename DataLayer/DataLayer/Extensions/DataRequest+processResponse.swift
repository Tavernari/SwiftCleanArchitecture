//
//  DataRequest+processResponse.swift
//  DataLayer
//
//  Created by Victor C Tavernari on 21/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Alamofire
import Foundation

extension DataRequest {
    func processResponse<ResultData: Decodable>(completion: @escaping (Result<ResultData, Error>) -> Void) {
        responseDecodable { (response: DataResponse<ResultData, AFError>) in
            switch response.result {
            case let .success(reponseData):
                completion(.success(reponseData))
            case let .failure(error):
                if let underlyingError = error.underlyingError {
                    completion(.failure(underlyingError))
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
}
