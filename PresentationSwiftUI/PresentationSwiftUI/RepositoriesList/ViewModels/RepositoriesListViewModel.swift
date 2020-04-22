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

    func done(data: [GitRepository]) {
        items = data.map(GHRepositoryViewModel.init)
    }

    func failure(withError error: FetchGitRepositoriesError) {
        self.error = error.localizedDescription
    }
}

class GHRepositoryViewModel: Identifiable, ObservableObject {
    let id = UUID()
    private var ghRepository: GitRepository

    @Published var image = R.image.icnAcompanhar()

    init(ghRepository: GitRepository) {
        self.ghRepository = ghRepository
        fetchImage(fromURL: self.ghRepository.image)
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

    private func fetchImage(fromURL url: String) {
        guard let fetchURLImage = URL(string: url) else { return }

        URLSession.shared.dataTask(with: fetchURLImage) { data, _, _ in
            guard let data = data else { return }

            self.image = UIImage(data: data)!
        }.resume()
    }
}
