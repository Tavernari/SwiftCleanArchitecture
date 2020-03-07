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
import Domain

extension IndexPath {
    static func extractRow(indexPath: IndexPath) -> Int {
        return indexPath.row
    }
}

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

    fileprivate func populateCell(index: Int, repository: Repository, cell: RepositoriesTableViewCell) {
        cell.repositoryAuthor = repository.author
        cell.repositoryName = repository.name
        cell.repositoryDescription = repository.description
        cell.repositoryImage = repository.image
        cell.repositoryForkCount = "\(repository.forkCount)"
        cell.repositoryStarCount = "\(repository.starCount)"
        cell.repositoryIssueCount = "\(repository.issuesCount)"
    }

    fileprivate func handleStatus(status: GitRepositoriesListStatus) {
        switch status {
        case .loading:
            self.showLoadingIndicator(text: "Loading")
        case .loaded:
            self.removeLoadingIndicator()
        case .fail(let errorMessage):
            print(errorMessage)
        }
    }

    fileprivate func deselectRow(indexPath: IndexPath) {
        self.tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
    }

    fileprivate func bindViewModel() {
        let cellIdentifier = R.reuseIdentifier.repositoriesTableViewCell.identifier
        viewModel
            .repositories
            .bind(to:
                tableView
                .rx
                .items(cellIdentifier: cellIdentifier)) { (index, repository, cell) in
                    guard let cell = cell as? RepositoriesTableViewCell else {
                        return
                    }
                    self.populateCell(index: index, repository: repository, cell: cell)
            }.disposed(by: disposeBag)

        tableView
            .rx
            .itemSelected
            .do(onNext:deselectRow)
            .map(IndexPath.extractRow)
            .subscribe(viewModel.select)
            .disposed(by: disposeBag)

        viewModel
            .status
            .subscribe(onNext: handleStatus)
            .disposed(by: disposeBag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        bindViewModel()

        title = "Repositories"
        
        self.viewModel.search.onNext("Javascript")
    }
}
