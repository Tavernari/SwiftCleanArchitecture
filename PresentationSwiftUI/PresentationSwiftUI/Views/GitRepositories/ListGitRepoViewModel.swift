//
//  ListGitRepoViewModel.swift
//  PresentationSwiftUI
//
//  Created by Victor C Tavernari on 10/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Combine
import Domain

class ListGitRepoViewModel: ObservableObject {
    @Published var isLoading: Bool = true
    @Published var term: String = ""
    @Published var dataSource: [ListGitRepoRowModel] = []
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
                self.dataSource = gitRepos.map(ListGitRepoRowModel.init)
            case .failure:
                self.dataSource = []
            }
        }
    }
}
