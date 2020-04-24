//
//  PullRequestShowViewModel.swift
//  PresentationSwiftUI
//
//  Created by Lucas Silveira on 23/04/20.
//  Copyright © 2020 blu. All rights reserved.
//

import Domain
import Foundation

class GHCommitsViewModel: Identifiable {
    let id = UUID()
    var ghCommit: GitCommit

    init(ghCommit: GitCommit) {
        self.ghCommit = ghCommit
    }

    var author: String {
        return ghCommit.name
    }

    var message: String {
        return ghCommit.message
    }

    var sha: String {
        return ghCommit.sha
    }
}

class PullRequestShowViewModel: ObservableObject {
    private var useCase: FetchPullRequestCommitsUseCaseProtocol

    @Published var prName: String? = ""
    @Published var commits: [GHCommitsViewModel] = []
    @Published var error: String? = nil

    init(useCase: FetchPullRequestCommitsUseCaseProtocol, prName: String, repoName: String, ownerName: String) {
        self.useCase = useCase
        self.useCase.delegateInterfaceAdapter = self

        self.prName = prName
        self.useCase.execute(repoName: repoName, ownerName: ownerName)
    }
}

extension PullRequestShowViewModel: FetchPullRequestCommitsInterfaceAdapter {
    func doing() {
        //
    }

    func done(data: [GitCommit]) {
        commits = data.map(GHCommitsViewModel.init)
    }

    func failure(error: Error) {
        self.error = error.localizedDescription
    }
}
