//
//  MainCoordinator.swift
//  Presentation
//
//  Created by Victor C Tavernari on 06/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import UIKit
import RxSwift
import DataSource
import Domain

class MainCoordinator: Coordinator {
    var childrens: [Coordinator] = []

    private let navigationController: UINavigationController
    private let disposeBag = DisposeBag()
    required init(withNavigation navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let listGitRepositoryUseCase = DoListGitRepositoryUseCase(repository: GithubRepoRepository())
        let viewModel = RepositoriesTableViewModel(listGitRepositoryUseCase: listGitRepositoryUseCase)

        viewModel.route.subscribe(onNext: {
            if case .showPullRequests(let repo) = $0 {
                self.showPullRequests(repo: repo)
            }
        }).disposed(by: self.disposeBag)

        let vc = RepositoriesTableViewController.initWith(withViewModel: viewModel)
        self.navigationController.viewControllers = [vc]
    }

    func showPullRequests(repo: GitRepository) {
        let dataSource = GithubPullRequestDataSource()
        let repository = GitPullRequestDataRepository(dataSource: dataSource)
        let useCase = DoListPullRequestsUseCase(repository: repository)
        let viewModel = GitListPullRequestViewModel(listPullRequestsUseCase: useCase)
        let vc = GitPullRequestsViewController.initWith(withViewModel: viewModel, andRepo: repo)
        self.navigationController.pushViewController(vc, animated: true)
    }
}
