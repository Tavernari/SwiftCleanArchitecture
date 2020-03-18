//
//  GitPullRequestsViewController.swift
//  Presentation
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import UIKit
import Domain

class GitPullRequestsViewController: UIViewController {

    final class func initWith(withViewModel viewModel: GitPullRequestsViewModel, andRepo repo: GitRepository) -> GitPullRequestsViewController {
        let vc = GitPullRequestsViewController()
        vc.viewModel = viewModel
        vc.repo = repo
        return vc
    }

    private(set) var viewModel: GitPullRequestsViewModel!
    private(set) var repo: GitRepository!

    private var dataSource: [GitPullRequest] { self.viewModel.pullRequests.value }

    @IBOutlet private weak var tableView: UITableView!

    fileprivate func configTableView() {
        tableView.register(R.nib.gitPullRequestsTableViewCell)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90
        tableView.delegate = self
        tableView.dataSource = self
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
        case .none:
            break
        }
    }

    fileprivate func deselectRow(indexPath: IndexPath) {
        self.tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
    }

    fileprivate func bindViewModel() {
        self.viewModel.status.observe(listener: self.handleStatus)
        self.viewModel.pullRequests.observe { _ in self.tableView.reloadData() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(repo.name) Pull Requests"
        configTableView()
        viewModel.load(repo: repo)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindViewModel()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        self.viewModel.status.removeAllObservers()
        self.viewModel.pullRequests.removeAllObservers()
    }
}

extension GitPullRequestsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.viewModel.select(index: indexPath.row)
    }
}

extension GitPullRequestsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.gitPullRequestsTableViewCell, for: indexPath)!
        let index = indexPath.row
        let data = self.dataSource[index]
        self.populateCell(index: index, pullRequests: data, cell: cell)
        return cell
    }


}
