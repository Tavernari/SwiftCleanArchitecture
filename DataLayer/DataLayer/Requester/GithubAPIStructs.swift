//
//  GithubServer.swift
//  DataLayer
//
//  Created by Victor C Tavernari on 09/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public struct GithubAPIError: Codable, LocalizedError {
    public let message: String
    public init(message: String) {
        self.message = message
    }

    public var errorDescription: String? { message }

    public static func make(data: Data?) -> GithubAPIError? {
        guard let data = data else {
            return nil
        }

        return try? JSONDecoder().decode(GithubAPIError.self, from: data)
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
