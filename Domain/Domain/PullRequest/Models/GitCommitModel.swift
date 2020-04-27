//
//  GitCommit.swift
//  Domain
//
//  Created by Lucas Silveira on 23/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public struct GitCommitModel: Equatable {
    public var sha = ""
    public var name = ""
    public var email = ""
    public var date: Date?
    public var message = ""

    public init() {}
}
