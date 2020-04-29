//
// Created by Victor C Tavernari on 29/04/20.
// Copyright (c) 2020 blu. All rights reserved.
//

import DomainLayer
import SwiftUI

class GitCommitsUIModel: Identifiable {
    let id = UUID()
    var gitCommit: GitCommitModel

    init(gitCommit: GitCommitModel) {
        self.gitCommit = gitCommit
    }

    var author: String {
        return gitCommit.name
    }

    var message: String {
        return gitCommit.message
    }

    var sha: String {
        return gitCommit.sha
    }
}
