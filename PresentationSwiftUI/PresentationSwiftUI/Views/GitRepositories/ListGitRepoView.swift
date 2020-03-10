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

struct ListGitRepoRowViewModel: Identifiable {
    var id = UUID()

    let item: GitRepository

    var title: String { item.name }
    var author: String { item.author }
    var description: String { item.description }
    var starCount: Int { item.starCount }
    var forkCount: Int { item.forkCount }
    var issuesCount: Int { item.issuesCount }

    init(item: GitRepository) {
        self.item = item
    }
}

class ListGitRepoViewModel: ObservableObject {
    @Published var isLoading: Bool = true
    @Published var term: String = ""
    @Published var dataSource: [ListGitRepoRowViewModel] = []
    private var disposables = Set<AnyCancellable>()

    private let useCase: ListGitRepositoryUseCase
    init(useCase: ListGitRepositoryUseCase) {
        self.useCase = useCase

        $term
            .dropFirst(1)
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink(receiveValue: executeUseCase)
            .store(in: &disposables)

    }

    private func executeUseCase(term:String) {
        self.isLoading = true
        self.useCase.execute(term: term) { (result) in
            self.isLoading = false
            switch result {
            case .success(let gitRepos):
                self.dataSource = gitRepos.map(ListGitRepoRowViewModel.init)
            case .failure:
                self.dataSource = []
            }
        }
    }
}

struct ListGitRepoView: View {

    @ObservedObject var viewModel: ListGitRepoViewModel

    var listPullRequestsViewModel: ListPullRequestsViewModel {
         let dataSource = GithubPullRequestDataSource()
         let repository = GitPullRequestDataRepository(dataSource: dataSource)
         let useCase = DoListPullRequestsUseCase(repository: repository)
         return ListPullRequestsViewModel(useCase: useCase)
     }

    init(viewModel: ListGitRepoViewModel){
        self.viewModel = viewModel
        self.viewModel.term = "Swift"
    }

    var body: some View {
        VStack {
            if viewModel.isLoading {
                Text("loading")
            } else {
                List {
                    Section {
                        ForEach(viewModel.dataSource, content: { repo in
                            NavigationLink(
                            destination: PullRequestsView(
                                repo: repo,
                                viewModel: self.listPullRequestsViewModel)) {
                                VStack {
                                    Text(repo.title)
                                }
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
        let dataSource = GithubRepoDataSource()
        let repository = DataSource.GitRepoRepository(dataSource: dataSource)
        let listGitRepositoryUseCase = DoListGitRepositoryUseCase(repository: repository)
        let viewModel = ListGitRepoViewModel(useCase: listGitRepositoryUseCase)
        return ListGitRepoView(viewModel: viewModel)
    }
}
