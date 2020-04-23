//
//  Date+ghDateFormat.swift
//  PresentationSwiftUI
//
//  Created by Lucas Silveira on 23/04/20.
//  Copyright © 2020 blu. All rights reserved.
//

import Foundation

extension Date {
    func ghDateFormat() -> String {
        // get formatter
        let printDateFormatter = DateFormatter()
        printDateFormatter.dateFormat = "dd/MM/yyyy HH:mm"

        let formatedDate = printDateFormatter.string(from: self)

        return formatedDate.description
    }
}
