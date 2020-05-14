//
//  LocalHostFacade.swift
//  PresentationLayerUITests
//
//  Created by Victor C Tavernari on 14/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import SwiftLocalhost

extension LocalhostServer {
    func githubGet(path: String, code: Int, data: Any?) {
        get(path, routeBlock: { _ in
            let requestURL: URL = URL(string: "http://localhost:\(self.portNumber)\(path)")!
            let httpUrlResponse = HTTPURLResponse(url: requestURL,
                                                  statusCode: code,
                                                  httpVersion: nil,
                                                  headerFields: ["Content-Type": "application/json"])!
            return LocalhostServerResponse(httpUrlResponse: httpUrlResponse, data: data)
        })
    }
}
