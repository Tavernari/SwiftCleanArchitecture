//
//  String+ghDateFormat.swift
//  PresentationSwiftUI
//
//  Created by Lucas Silveira on 23/04/20.
//  Copyright © 2020 blu. All rights reserved.
//

import Foundation

extension String {
    func ghDateFormat() -> String {
        // get formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "pt_BR")

        let date: Date = dateFormatter.date(from: self)!

        // get formatter
        let printDateFormatter = DateFormatter()
        printDateFormatter.dateFormat = "dd/MM/yyyy HH:mm"

        let formatedDate = printDateFormatter.string(from: date)

        return formatedDate.description
    }
}
