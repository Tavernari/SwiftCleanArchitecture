//
//  RepositoriesListViewModel.swift
//  PresentationSwiftUI
//
//  Created by Lucas Silveira on 22/04/20.
//  Copyright © 2020 blu. All rights reserved.
//

import DomainLayer
import UIKit

class GitRepositoriesListViewModel: ObservableObject {
    @Published var items: [GitRepositoryUIModel] = []
    @Published var error: String? = nil
    @Published var showStats = false
    @Published var multiplier: Double = 0

    init(fetchGitRepositoriesUseCase: FetchGitRepositoriesUseCaseProtocol) {
        var fetchGitRepositoriesUseCase = fetchGitRepositoriesUseCase
        fetchGitRepositoriesUseCase.delegateInterfaceAdapter = self
        fetchGitRepositoriesUseCase.execute(term: "Swift")
    }
}

extension GitRepositoriesListViewModel: FetchGitRepositoriesInterfaceAdapter {
    func doing() {
        //
    }

    func done(data: [GitRepositoryModel]) {
        items = data.map(GitRepositoryUIModel.init)
    }

    func failure(withError error: FetchGitRepositoriesError) {
        self.error = error.localizedDescription
    }
}
