//
//  GitRepositoriesListViewModelAnalytics.swift
//  PresentationLayer
//
//  Created by Victor C Tavernari on 07/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

class GitRepositoriesListViewModelAnalytics: GitRepositoriesListViewModelAnalyticsProtocol {
    func itemSelected(name: String) {
        AppEvents.gitRepoSelected(repoName: name).dispatch()
    }

    func searched(term: String) {
        AppEvents.gitRepoTermSearched(term: term).dispatch()
    }

    func screen() {
        ScreenEvents.gitRepositoriesList.dispatch()
    }
}
