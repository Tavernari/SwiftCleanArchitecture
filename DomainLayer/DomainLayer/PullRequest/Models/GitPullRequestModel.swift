//
//  GitPullRequests.swift
//  Domain
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public struct GitPullRequestModel: Equatable {
    public var id = 0
    public var author = ""
    public var title = ""
    public var description = ""
    public var image = ""
    public var createdAt: Date?
    public var updatedAt: Date?
    public var commentsCount = 0
    public var commitsCount = 0
    public var additionsCount = 0
    public var deletionsCount = 0
    public var changedFilesCount = 0

    public init() {}
}
