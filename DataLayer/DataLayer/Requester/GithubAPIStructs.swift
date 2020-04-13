//
//  GithubServer.swift
//  DataLayer
//
//  Created by Victor C Tavernari on 09/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public struct GithubAPIErrorData: Codable {
    public let message: String
    public init(message: String) {
        self.message = message
    }

    public static func decode(from data: Data?) -> GithubAPIErrorData? {
        guard let data = data else {
            return nil
        }

        return try? JSONDecoder().decode(GithubAPIErrorData.self, from: data)
    }
}

struct GithubServerURL {
    static var path = { () -> String in
        var url = "https://api.github.com"

        if ProcessInfo.processInfo.arguments.contains("ui-testing"),
            let port = Int(ProcessInfo.processInfo.environment["localhostPort"] ?? "80") {
            url = "http://localhost:\(port)"
        }

        return url
    }()
}
