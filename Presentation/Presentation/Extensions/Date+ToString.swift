//
//  Date+ToString.swift
//  Presentation
//
//  Created by Victor C Tavernari on 08/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

enum DateStringFormats: String {
    case ddMMyyyyHHmmss = "dd/MM/yyyy HH:mm:ss"
}

extension Date {
    func string(format:DateStringFormats) -> String {
        return self.string(format: format.rawValue)
    }

    func string(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
