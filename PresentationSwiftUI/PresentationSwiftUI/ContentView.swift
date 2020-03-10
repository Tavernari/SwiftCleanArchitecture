//
//  ContentView.swift
//  PresentationSwiftUI
//
//  Created by Victor C Tavernari on 09/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import SwiftUI
import Domain
import DataSource
import Combine

struct ContentView: View {

    var listGitRepoViewModel: ListGitRepoViewModel {
        let dataSource = GithubRepoDataSource()
        let repository = DataSource.GitRepoRepository(dataSource: dataSource)
        let listGitRepositoryUseCase = DoListGitRepositoryUseCase(repository: repository)
        return ListGitRepoViewModel(useCase: listGitRepositoryUseCase)
    }

    var body: some View {
        NavigationView {
            ListGitRepoView(viewModel: listGitRepoViewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
