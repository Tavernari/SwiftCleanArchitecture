//
//  String+ToDate.swift
//  Data
//
//  Created by Victor C Tavernari on 08/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

extension String {
    func toYYYY_MM_DD_T_HH_mm_SS_Z() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: self)
    }
}
