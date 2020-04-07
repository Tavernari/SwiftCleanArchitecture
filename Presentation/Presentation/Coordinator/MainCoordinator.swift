//
//  MainCoordinator.swift
//  Presentation
//
//  Created by Victor C Tavernari on 06/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import DataSource
import Domain
import UIKit

class MainCoordinator: NSObject, Coordinator {
    var childrens: [Coordinator] = []

    private let navigationController: UINavigationController
    private let assembler: MainAssembler
    required init(withNavigation navigationController: UINavigationController, assembler: MainAssembler) {
        self.navigationController = navigationController
        self.assembler = assembler
    }

    func start() {
        let configDataSource = assembler.resolver.resolve(ConfigDataSource.self)!
        let gitRepoDataSource = assembler.resolver.resolve(GitRepoDataSource.self)!
        let gitRepoRepository = DataSource.GitRepoRepository(gitRepoDataSource: gitRepoDataSource)
        let reliabilityRepoCalculatorUseCase = ReliabilityRepoCalculator()
        let configRepository = ConfigDataRepository(dataSource: configDataSource)

        let fetchGitRepositories = FetchGitRepositoriesUseCase(
            gitRepoRepository: gitRepoRepository,
            configRepository: configRepository,
            reliabilityCalculatorUseCase: reliabilityRepoCalculatorUseCase
        )

        let viewModel = ListOfRepositoriesViewModel(fetchGitRepositoriesUseCase: fetchGitRepositories)

        fetchGitRepositories.delegateInterfaceAdapter = viewModel

        viewModel.route.observe { route in
            switch route {
            case let .showError(errorMessage):
                self.showAPIError(errorMessage: errorMessage)
            case let .showPullRequests(repo):
                self.showPullRequests(repo: repo)
            case .none:
                break
            }
        }

        let vc = ListOfRepositoriesViewController.initWith(viewModel: viewModel)
        navigationController.viewControllers = [vc]
    }

    func showAPIError(errorMessage: String) {
        let viewModel = APIErrorViewModel(errorMessage: errorMessage)

        let vc = APIErrorViewController.initWith(withViewModel: viewModel)
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true, completion: nil)

        viewModel.route.observe { route in
            if case .ok = route {
                vc.dismiss(animated: true, completion: nil)
            }
        }
    }

    func showPullRequests(repo: GitRepository) {
        let dataSource = assembler.resolver.resolve(GitPullRequestDataSource.self)!
        let repository = GitPullRequestDataRepository(dataSource: dataSource)
        let useCase = FetchPullRequestsUseCase(repository: repository)
        let viewModel = ListOfPullRequestsViewModel(listPullRequestsUseCase: useCase)
        useCase.delegateInterfaceAdapter = viewModel

        viewModel.route.observe { route in
            if case let .showPullRequestDetail(id, repo) = route {
                self.showPullRequestDetail(id: id, repo: repo)
            }
        }

        let vc = ListOfPullRequestsViewController.initWith(withViewModel: viewModel, andRepo: repo)
        navigationController.pushViewController(vc, animated: true)
    }

    func showPullRequestDetail(id: Int, repo: GitRepository) {
        let dataSource = assembler.resolver.resolve(GitPullRequestDataSource.self)!
        let repository = GitPullRequestDataRepository(dataSource: dataSource)
        let useCase = FetchPullRequestDetailUseCase(repository: repository)
        let viewModel = PullRequestDetailsViewModel(useCase: useCase)
        useCase.delegateInterfaceAdapter = viewModel
        let vc = PullRequestDetailsViewController.initWith(viewModel: viewModel, id: id, repo: repo)
        navigationController.pushViewController(vc, animated: true)
    }
}
