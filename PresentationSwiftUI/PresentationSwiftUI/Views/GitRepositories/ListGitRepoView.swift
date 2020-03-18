//
//  ListGitRepoView.swift
//  PresentationSwiftUI
//
//  Created by Victor C Tavernari on 09/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import SwiftUI
import Domain
import Combine
import DataSource

struct ListGitRepoView: View {

    @ObservedObject var viewModel: ListGitRepoViewModel

    init(){
        let dataSource = GithubRepoDataSource()
        let repository = DataSource.GitRepoRepository(dataSource: dataSource)
        let listGitRepositoryUseCase = DoListGitRepositoryUseCase(repository: repository)
        self.viewModel = ListGitRepoViewModel(useCase: listGitRepositoryUseCase)

        self.viewModel.term = "Swift"
    }

    var body: some View {
        VStack {
            if viewModel.isLoading {
                Text("loading")
            } else {
                List {
                    Section {
                        ForEach(viewModel.dataSource, content: { rowModel in
                            NavigationLink( destination: PullRequestsView(rowModel: rowModel)) {
                                ListGitRepoRowView(rowModel: rowModel)
                            }
                        })
                    }
                }
            }
        }
        .navigationBarTitle("Repositories")
    }
}

struct ListGitRepoView_Previews: PreviewProvider {

    static var previews: some View {
        return ListGitRepoView()
    }
}
