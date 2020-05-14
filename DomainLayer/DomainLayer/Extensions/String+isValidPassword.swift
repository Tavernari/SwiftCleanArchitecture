//
//  String+isValidPassword.swift
//  DomainLayer
//
//  Created by Lucas Silveira on 14/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

extension String {
    func isValidPassword() -> Bool {
        count > 6
    }
}
