//
//  ErrorDispatcher.swift
//  Analytics
//
//  Created by Victor C Tavernari on 13/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public protocol ErrorDispatcher {
    func error(_ error: Error, addtionalUserInfo userInfo:[String: Any]?)
}
