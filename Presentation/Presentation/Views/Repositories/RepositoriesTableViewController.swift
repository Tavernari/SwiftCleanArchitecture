//
//  RepositoriesTableViewController.swift
//  Presentation
//
//  Created by Victor C Tavernari on 02/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Alamofire
import AlamofireImage
import Domain

class RepositoriesTableViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    final class func build(withViewModel viewModel: GitRepositoriesListViewModel) -> RepositoriesTableViewController {
        let vc = RepositoriesTableViewController()
        vc.viewModel = viewModel
        return vc
    }

    private(set) var viewModel: GitRepositoriesListViewModel!
    private let disposeBag = DisposeBag()
        
    fileprivate func configTableView() {
        tableView.register(R.nib.repositoriesTableViewCell)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90
    }

    fileprivate func bindViewModel() {
        let cellIdentifier = R.reuseIdentifier.repositoriesTableViewCell.identifier
        viewModel
            .repositories
            .do(onNext: { _ in self.removeLoadingIndicator() })
            .bind(to:
                tableView
                .rx
                .items(cellIdentifier: cellIdentifier)) { (index, repository, cell) in
                    guard let cell = cell as? RepositoriesTableViewCell else {
                        return
                    }

                    cell.repositoryAuthor = repository.author
                    cell.repositoryName = repository.name
                    cell.repositoryDescription = repository.description
                    cell.repositoryImage = repository.image
                    cell.repositoryForkCount = "\(repository.forkCount)"
                    cell.repositoryStarCount = "\(repository.starCount)"
                    cell.repositoryIssueCount = "\(repository.issuesCount)"
            }.disposed(by: disposeBag)

        tableView
            .rx
            .itemSelected
            .do(onNext: { self.tableView.cellForRow(at: $0)?.setSelected(false, animated: true) })
            .map{ $0.row }
            .subscribe( viewModel.select )
            .disposed(by: self.disposeBag)

        viewModel
            .status
            .subscribe(onNext: { status in
                switch status {
                case .loading:
                    self.showLoadingIndicator(text: "Loading")
                case .loaded:
                    self.removeLoadingIndicator()
                case .fail(let errorMessage):
                    print(errorMessage)
                }
            })
            .disposed(by: self.disposeBag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        bindViewModel()

        title = "Repositories"
        
        self.viewModel.search.onNext("Javascript")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
}
