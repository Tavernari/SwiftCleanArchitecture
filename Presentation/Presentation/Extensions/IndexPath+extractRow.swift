//
//  IndexPath+extractRow.swift
//  Presentation
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

extension IndexPath {
    static func extractRow(indexPath: IndexPath) -> Int {
        return indexPath.row
    }
}
