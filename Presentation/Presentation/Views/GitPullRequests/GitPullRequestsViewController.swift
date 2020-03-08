//
//  GitPullRequestsViewController.swift
//  Presentation
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import UIKit
import Domain
import RxSwift
import RxCocoa

class GitPullRequestsViewController: UIViewController {

    final class func initWith(withViewModel viewModel: GitPullRequestsViewModel, andRepo repo: GitRepository) -> GitPullRequestsViewController {
        let vc = GitPullRequestsViewController()
        vc.viewModel = viewModel
        vc.repo = repo
        return vc
    }

    private(set) var viewModel: GitPullRequestsViewModel!
    private(set) var repo: GitRepository!
    private let disposeBag = DisposeBag()

    @IBOutlet private weak var tableView: UITableView!

    fileprivate func configTableView() {
        tableView.register(R.nib.gitPullRequestsTableViewCell)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90
    }

    fileprivate func populateCell(index: Int, pullRequests: GitPullRequest, cell: GitPullRequestsTableViewCell) {
        cell.pullRequestAuthor = pullRequests.author
        cell.pullRequestImage = pullRequests.image
        cell.pullRequestTitle = pullRequests.title
        cell.pullRequestDescription = pullRequests.description
        cell.pullRequestDate = pullRequests.date?.string(format: .ddMMyyyyHHmmss) ?? ""
    }

    fileprivate func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    fileprivate func handleStatus(status: ViewModelLoadStatus) {
        switch status {
        case .loading:
            self.showLoadingIndicator(text: "Loading")
        case .loaded:
            self.removeLoadingIndicator()
        case .fail(let errorMessage):
            self.removeLoadingIndicator()
            self.showError(message: errorMessage)
        }
    }

    fileprivate func deselectRow(indexPath: IndexPath) {
        self.tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
    }

    fileprivate func bindViewModel() {
        let cellIdentifier = R.reuseIdentifier.gitPullRequestsTableViewCell.identifier
        viewModel
            .pullRequests
            .bind(to:
                tableView
                .rx
                .items(cellIdentifier: cellIdentifier)) { (index, pullRequests, cell) in
                    guard let cell = cell as? GitPullRequestsTableViewCell else {
                        return
                    }
                    self.populateCell(index: index, pullRequests: pullRequests, cell: cell)
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
        self.title = "\(repo.name) Pull Requests"
        configTableView()
        bindViewModel()
        viewModel.load.onNext(repo)
    }
}
