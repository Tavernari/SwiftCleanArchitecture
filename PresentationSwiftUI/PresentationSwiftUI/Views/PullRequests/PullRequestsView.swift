//
//  PullRequestsView.swift
//  PresentationSwiftUI
//
//  Created by Victor C Tavernari on 09/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import SwiftUI
import Domain
import Combine
import DataSource

struct ListPullRequestsRowViewModel: Identifiable {
    var id = UUID()

    let item: GitPullRequest

    var title: String { item.title }
    var author: String { item.author }
    var description: String { item.description }

    init(item: GitPullRequest) {
        self.item = item
    }
}

class ListPullRequestsViewModel: ObservableObject {
    @Published var isLoading: Bool = true
    @Published var listGitRepoRowViewModel: ListGitRepoRowViewModel?
    @Published var dataSource: [ListPullRequestsRowViewModel] = []
    private var disposables = Set<AnyCancellable>()

    private let useCase: ListPullRequestsUseCase
    init(useCase: ListPullRequestsUseCase) {
        self.useCase = useCase

        $listGitRepoRowViewModel
            .compactMap { $0?.item }
            .sink(receiveValue: executeUseCase)
            .store(in: &disposables)

    }

    private func executeUseCase(repo: GitRepository) {
        self.isLoading = true
        self.useCase.execute(repo: repo) { (result) in
            self.isLoading = false
            switch result {
            case .success(let gitRepos):
                self.dataSource = gitRepos.map(ListPullRequestsRowViewModel.init)
            case .failure:
                self.dataSource = []
            }
        }
    }
}

struct PullRequestsView: View {

    @ObservedObject var viewModel: ListPullRequestsViewModel

    private let repo: ListGitRepoRowViewModel
    init(repo: ListGitRepoRowViewModel, viewModel: ListPullRequestsViewModel){
        self.viewModel = viewModel
        self.repo = repo
        self.viewModel.listGitRepoRowViewModel = self.repo
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
        .navigationBarTitle("\(self.repo.title) Pull Requests", displayMode: .inline)
    }
}
