//
//  TodoData.swift
//  Dominio
//
//  Created by Victor C Tavernari on 01/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public struct TodoData {
    public var value: String
    public var date: Date

    public init(value: String, date: Date = .init()){
        self.value = value
        self.date = date
    }
}
