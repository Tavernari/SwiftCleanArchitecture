//
// Created by Victor C Tavernari on 29/04/20.
// Copyright (c) 2020 blu. All rights reserved.
//

import DomainLayer
import SwiftUI

class GitRepositoryUIModel: Identifiable, ObservableObject {
    let id = UUID()
    var ghRepository: GitRepositoryModel

    init(ghRepository: GitRepositoryModel) {
        self.ghRepository = ghRepository
    }

    var name: String {
        return ghRepository.name
    }

    var login: String {
        return ghRepository.author
    }

    var description: String {
        return ghRepository.description
    }

    var stargazers: Int {
        return ghRepository.starCount
    }

    var forks: Int {
        return ghRepository.forkCount
    }

    var issues: Int {
        return ghRepository.issuesCount
    }

    var showStats: Bool {
        return ghRepository.reliability.isEnable
    }

    var stats: Double {
        return ghRepository.reliability.score
    }

    var avatarURL: String {
        return ghRepository.image
    }
}
