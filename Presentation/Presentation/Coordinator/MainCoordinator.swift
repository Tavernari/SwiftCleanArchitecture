//
//  MainCoordinator.swift
//  Presentation
//
//  Created by Victor C Tavernari on 06/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import UIKit
import DataSource
import Domain

class MainCoordinator: NSObject, Coordinator {
    var childrens: [Coordinator] = []

    private let navigationController: UINavigationController
    required init(withNavigation navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let dataSource = GithubRepoDataSource()
        let repository = DataSource.GitRepoRepository(dataSource: dataSource)
        let listGitRepositoryUseCase = DoListGitRepositoryUseCase(repository: repository)
        let viewModel = RepositoriesTableViewModel(listGitRepositoryUseCase: listGitRepositoryUseCase)

        viewModel.route.observe { (route) in
            if case .showPullRequests(let repo) = route {
                self.showPullRequests(repo: repo)
            }
        }

        let vc = RepositoriesTableViewController.initWith(withViewModel: viewModel)
        self.navigationController.viewControllers = [vc]
    }

    func showPullRequests(repo: GitRepository) {
        let dataSource = GithubPullRequestDataSource()
        let repository = GitPullRequestDataRepository(dataSource: dataSource)
        let useCase = DoListPullRequestsUseCase(repository: repository)
        let viewModel = GitListPullRequestViewModel(listPullRequestsUseCase: useCase)

        viewModel.route.observe { (route) in
            if case .showPullRequestDetail(let id, let repo) = route {
                self.showPullRequestDetail(id: id, repo: repo)
            }
        }

        let vc = GitPullRequestsViewController.initWith(withViewModel: viewModel, andRepo: repo)
        self.navigationController.pushViewController(vc, animated: true)
    }

    func showPullRequestDetail(id: Int, repo: GitRepository) {
        let dataSource = GithubPullRequestDataSource()
        let repository = GitPullRequestDataRepository(dataSource: dataSource)
        let useCase = DoGetPullRequestDetailUseCase(repository: repository)
        let viewModel = PullRequestDetailViewModel(useCase: useCase)
        let vc = GitPullRequestDetailViewController.initWith(viewModel: viewModel, id: id, repo: repo)
        self.navigationController.pushViewController(vc, animated: true)
    }
}
