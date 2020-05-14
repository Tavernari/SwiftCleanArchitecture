//
//  Array+filterType.swift
//  Lytics
//
//  Created by Victor C Tavernari on 14/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

extension Array where Element == ProviderType {
    func filterEnabled<Type>() -> [Type] {
        self.filter{ $0.enable }
            .compactMap{ $0 as? Type }
    }
}
