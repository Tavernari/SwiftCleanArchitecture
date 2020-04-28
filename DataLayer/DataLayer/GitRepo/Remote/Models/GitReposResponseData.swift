//
// Created by Victor C Tavernari on 27/04/20.
// Copyright (c) 2020 Taverna Apps. All rights reserved.
//

import Foundation

public struct GitReposResponseData: Codable {
    public var items: [GitbRepositoryData] = []
    public init() {}
}
