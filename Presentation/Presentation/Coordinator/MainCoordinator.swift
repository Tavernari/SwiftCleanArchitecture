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

class MainCoordinator: Coordinator {
    var childrens: [Coordinator] = []

    private let navigationController: UINavigationController
    private let disposeBag = DisposeBag()
    required init(withNavigation navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = RepositoriesTableViewModel(gitRepository: GithubRepoRepository())

        viewModel.route.subscribe(onNext: {
            if case .showPullRequests(let owner, let repository) = $0 {
                self.showPullRequests(owner: owner, repository: repository)
            }
        }).disposed(by: self.disposeBag)

        let vc = RepositoriesTableViewController.build(withViewModel: viewModel)
        self.navigationController.viewControllers = [vc]
    }

    func showPullRequests(owner: String, repository: String) {
        let vc = UIViewController()
        self.navigationController.pushViewController(vc, animated: true)
    }

}
