//
//  RepositoriesLIstView.swift
//  PresentationSwiftUI
//
//  Created by Lucas Silveira on 22/04/20.
//  Copyright © 2020 blu. All rights reserved.
//

import DataLayer
import Domain
import SwiftUI

struct RepositoriesListView: View {
    @ObservedObject var viewModel: RepositoriesListViewModel

    var body: some View {
        List {
            ForEach(viewModel.items) { item in
                RepositoriesListItemView(repo: item)
                    .listRowInsets(EdgeInsets())
                    .padding(.vertical, 7)
                    .padding(.horizontal, 15)
            }
            .padding(.top, 10)
            .navigationBarTitle("Repos")
            .listRowInsets(EdgeInsets())
        }
    }
}

struct RepositoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = RepositoriesListViewModel(useCase: UseCaseFacade.fetchGitRepositoryUseCase())

        return RepositoriesListView(viewModel: viewModel)
    }
}
