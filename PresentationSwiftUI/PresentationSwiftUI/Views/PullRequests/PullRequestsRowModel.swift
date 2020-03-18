//
//  PullRequestsRowModel.swift
//  PresentationSwiftUI
//
//  Created by Victor C Tavernari on 10/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Domain

struct PullRequestsRowModel: Identifiable {
    var id = UUID()

    let item: GitPullRequest

    var title: String { item.title }
    var author: String { item.author }
    var description: String { item.description }

    init(item: GitPullRequest) {
        self.item = item
    }
}
