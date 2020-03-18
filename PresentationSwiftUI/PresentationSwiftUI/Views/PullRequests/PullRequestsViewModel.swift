//
//  PullRequestsViewModel.swift
//  PresentationSwiftUI
//
//  Created by Victor C Tavernari on 10/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation
import Combine
import Domain

class PullRequestsViewModel: ObservableObject {
    @Published var isLoading: Bool = true
    @Published var listGitRepoRowViewModel: ListGitRepoRowModel?
    @Published var dataSource: [PullRequestsRowModel] = []
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
                self.dataSource = gitRepos.map(PullRequestsRowModel.init)
            case .failure:
                self.dataSource = []
            }
        }
    }
}
