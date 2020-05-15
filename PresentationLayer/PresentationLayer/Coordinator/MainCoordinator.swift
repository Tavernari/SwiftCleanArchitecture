//
//  MainCoordinator.swift
//  Presentation
//
//  Created by Victor C Tavernari on 06/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import DataLayer
import DomainLayer
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
        let remoteConfigDataSource = assembler.resolver.resolve(GitRepoRemoteConfigDataSourceProtocol.self)!
        let gitRepoDataSource = assembler.resolver.resolve(GitRepoDataSourceProtocol.self)!
        let gitRepoRepository = GitRepoRepository(gitRepoDataSource: gitRepoDataSource,
                                                  remoteConfigDataSource: remoteConfigDataSource)
        let reliabilityRepoCalculatorUseCase = ReliabilityRepoCalculator()

        let fetchGitRepositories = FetchGitRepositoriesUseCase(
            gitRepoRepository: gitRepoRepository,
            reliabilityCalculatorUseCase: reliabilityRepoCalculatorUseCase
        )

        let analyticsInterface = GitRepositoriesListViewModelAnalytics()
        let viewModel = GitRepositoriesListViewModel(fetchGitRepositoriesUseCase: fetchGitRepositories,
                                                     delegateAnalyticsInterface: analyticsInterface)

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

        let vc = GitRepositoriesListViewController.initWith(viewModel: viewModel)
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

    func showPullRequests(repo: GitRepositoryModel) {
        let dataSource = assembler.resolver.resolve(GitPullRequestDataSourceProtocol.self)!
        let repository = GitPullRequestRepository(dataSource: dataSource)
        let useCase = FetchPullRequestsUseCase(repository: repository)
        let viewModel = GitPullRequestsListViewModel(fetchPullRequestsUseCase: useCase)
        useCase.delegateInterfaceAdapter = viewModel

        viewModel.route.observe { route in
            if case let .showPullRequestDetail(id, repo) = route {
                self.showPullRequestDetail(id: id, repo: repo)
            }
        }

        let vc = GitPullRequestsListViewController.initWith(withViewModel: viewModel, andRepo: repo)
        navigationController.pushViewController(vc, animated: true)
    }

    func showPullRequestDetail(id: Int, repo: GitRepositoryModel) {
        let dataSource = assembler.resolver.resolve(GitPullRequestDataSourceProtocol.self)!
        let repository = GitPullRequestRepository(dataSource: dataSource)
        let useCase = FetchPullRequestDetailUseCase(repository: repository)
        let viewModel = GitPullRequestDetailsViewModel(fetchPullRequestDetailUseCase: useCase)
        useCase.delegateInterfaceAdapter = viewModel
        let vc = GitPullRequestDetailsViewController.initWith(viewModel: viewModel, id: id, repo: repo)
        navigationController.pushViewController(vc, animated: true)
    }
}
