//
//  String+isValidEmail.swift
//  DomainLayer
//
//  Created by Lucas Silveira on 14/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
