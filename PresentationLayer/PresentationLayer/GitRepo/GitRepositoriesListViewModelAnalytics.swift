//
//  GitRepositoriesListViewModelAnalytics.swift
//  PresentationLayer
//
//  Created by Victor C Tavernari on 07/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Analytics

enum AppEvents: AnalyticsEventType {
    case gitRepoSelected(repoName: String)

    var data: [String: Any]? {
        switch self {
        case let .gitRepoSelected(repoName):
            return ["repoName": repoName]
        }
    }

    var name: String { "git_repo_select" }
}

class GitRepositoriesListViewModelAnalytics: GitRepositoriesListViewModelAnalyticsProtocol {
    func itemSelected(name: String) {
        AppEvents.gitRepoSelected(repoName: name).dispatch()
    }
}
