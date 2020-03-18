//
//  ListGitRepoRowModel.swift
//  PresentationSwiftUI
//
//  Created by Victor C Tavernari on 10/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Domain
import UIKit
import Alamofire
import AlamofireImage

struct ListGitRepoRowModel: Identifiable {
    var id = UUID()

    let item: GitRepository

    var title: String { item.name }
    var author: String { item.author }
    var description: String { item.description }
    var starCount: Int { item.starCount }
    var forkCount: Int { item.forkCount }
    var issuesCount: Int { item.issuesCount }
    var image: String { item.image }

    init(item: GitRepository) {
        self.item = item
    }
}
