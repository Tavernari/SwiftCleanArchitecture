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

class GitRepositoryUIModel: Identifiable, ObservableObject {
    let id = UUID()
    var ghRepository: GitRepositoryModel

    init(ghRepository: GitRepositoryModel) {
        self.ghRepository = ghRepository
    }

    var name: String {
        return ghRepository.name
    }

    var login: String {
        return ghRepository.author
    }

    var description: String {
        return ghRepository.description
    }

    var stargazers: Int {
        return ghRepository.starCount
    }

    var forks: Int {
        return ghRepository.forkCount
    }

    var issues: Int {
        return ghRepository.issuesCount
    }

    var showStats: Bool {
        return ghRepository.isReliabilityEnabled
    }

    var stats: Double {
        return ghRepository.reliabilityScore
    }

    var avatarURL: String {
        return ghRepository.image
    }
}
