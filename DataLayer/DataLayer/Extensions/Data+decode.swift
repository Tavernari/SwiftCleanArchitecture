//
// Created by Victor C Tavernari on 29/04/20.
// Copyright (c) 2020 Taverna Apps. All rights reserved.
//

import Foundation

extension Data {
    func decode<Type: Decodable>() throws -> Type {
        return try JSONDecoder().decode(Type.self, from: self)
    }
}
