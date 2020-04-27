//
//  RepositoriesListViewModel.swift
//  PresentationSwiftUI
//
//  Created by Lucas Silveira on 22/04/20.
//  Copyright © 2020 blu. All rights reserved.
//

import Domain
import UIKit

class RepositoriesListViewModel: ObservableObject {
    @Published var items: [GHRepositoryViewModel] = []
    @Published var error: String? = nil
    @Published var showStats = false
    @Published var multiplier: Double = 0

    init(useCase: FetchGitRepositoriesUseCaseProtocol) {
        var useCase = useCase
        useCase.delegateInterfaceAdapter = self
        useCase.execute(term: "Swift")
    }
}

extension RepositoriesListViewModel: FetchGitRepositoriesInterfaceAdapter {
    func doing() {
        //
    }

    func done(data: [GitRepositoryModel]) {
        items = data.map(GHRepositoryViewModel.init)
    }

    func failure(withError error: FetchGitRepositoriesError) {
        self.error = error.localizedDescription
    }
}

class GHRepositoryViewModel: Identifiable, ObservableObject {
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
