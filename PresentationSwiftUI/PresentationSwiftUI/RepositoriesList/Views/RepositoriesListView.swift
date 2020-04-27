//
//  RepositoriesLIstView.swift
//  PresentationSwiftUI
//
//  Created by Lucas Silveira on 22/04/20.
//  Copyright © 2020 blu. All rights reserved.
//

import DataLayer
import DomainLayer
import SwiftUI

struct RepositoriesListView: View {
    @ObservedObject var viewModel: GitRepositoriesListViewModel

    var body: some View {
        List {
            ForEach(viewModel.items) { item in
                NavigationLink(destination: PullRequestsListView(viewModel: .init(fetchPullRequestsUseCase: UseCaseFacade.fetchPullRequestsUseCase(), gitRepository: item.ghRepository), repo: item)) {
                    RepositoriesListItemView(repo: item)
                        .listRowInsets(EdgeInsets())
                        .padding(.leading, 20)
                        .padding(.vertical, 6)
                }
                .padding(.trailing, 10)
            }
            .padding(.top, 10)
            .navigationBarTitle("Repos")
            .listRowInsets(EdgeInsets())
        }
    }
}

struct RepositoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = GitRepositoriesListViewModel(fetchGitRepositoriesUseCase: UseCaseFacade.fetchGitRepositoryUseCase())

        return RepositoriesListView(viewModel: viewModel)
    }
}
