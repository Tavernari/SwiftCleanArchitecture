//
//  PullRequestsView.swift
//  PresentationSwiftUI
//
//  Created by Victor C Tavernari on 09/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import SwiftUI
import Domain
import DataSource

struct PullRequestsView: View {

    @ObservedObject var viewModel: PullRequestsViewModel

    private let rowModel: ListGitRepoRowModel
    init(rowModel: ListGitRepoRowModel){
        let dataSource = GithubPullRequestDataSource()
        let repository = GitPullRequestDataRepository(dataSource: dataSource)
        let useCase = DoListPullRequestsUseCase(repository: repository)
        self.viewModel = PullRequestsViewModel(useCase: useCase)

        self.rowModel = rowModel
        self.viewModel.listGitRepoRowViewModel = self.rowModel
    }

    var body: some View {
        VStack {
            if viewModel.isLoading {
                Text("loading")
            } else {
                List {
                    Section {
                        ForEach(viewModel.dataSource, content: { pullRequest in
                            VStack {
                                Text(pullRequest.title)
                            }
                        })
                    }
                }
            }
        }
        .navigationBarTitle("\(self.rowModel.title) Pull Requests", displayMode: .inline)
    }
}
