//
// Created by Victor C Tavernari on 28/04/20.
// Copyright (c) 2020 Taverna Apps. All rights reserved.
//

import Foundation

public struct FlagableConfig<DataType: Codable>: Codable {
    public let enable: Bool
    public let data: DataType
}
