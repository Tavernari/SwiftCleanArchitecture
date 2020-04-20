//
//  URLError+makeURLCommonsError.swift
//  Domain
//
//  Created by Victor C Tavernari on 20/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public extension URLError {
    func makeCommonError() -> URLCommonsError {
        switch code {
        case URLError.Code.notConnectedToInternet:
            return .noInternetConnection
        case URLError.Code.timedOut:
            return .timeOut
        default:
            return .generic(localizedDescription)
        }
    }
}
