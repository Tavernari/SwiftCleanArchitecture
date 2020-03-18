//
//  RepositoriesTableViewController.swift
//  Presentation
//
//  Created by Victor C Tavernari on 02/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import UIKit
import Domain

class RepositoriesTableViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    final class func initWith(withViewModel viewModel: GitRepositoriesListViewModel) -> RepositoriesTableViewController {
        let vc = RepositoriesTableViewController()
        vc.viewModel = viewModel
        return vc
    }

    private(set) var viewModel: GitRepositoriesListViewModel!
    private var dataSource: [GitRepository] { self.viewModel.repositories.value }
        
    fileprivate func configTableView() {
        tableView.register(R.nib.repositoriesTableViewCell)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90
        tableView.delegate = self
        tableView.dataSource = self
    }

    fileprivate func populateCell(index: Int, repository: GitRepository, cell: RepositoriesTableViewCell) {
        cell.repositoryAuthor = repository.author
        cell.repositoryName = repository.name
        cell.repositoryDescription = repository.description
        cell.repositoryImage = repository.image
        cell.repositoryForkCount = "\(repository.forkCount)"
        cell.repositoryStarCount = "\(repository.starCount)"
        cell.repositoryIssueCount = "\(repository.issuesCount)"
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
            self.removeLoadingIndicator()
        }
    }

    fileprivate func deselectRow(indexPath: IndexPath) {
        self.tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
    }

    fileprivate func bindViewModel() {

        self.viewModel.status.observe { (status) in
            self.handleStatus(status: status)
        }

        self.viewModel.repositories.observe { _ in self.tableView.reloadData() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()

        title = "Repositories"
        self.viewModel.search(term: "Swift")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindViewModel()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        self.viewModel.status.removeAllObservers()
        self.viewModel.repositories.removeAllObservers()
    }
}

extension RepositoriesTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        deselectRow(indexPath: indexPath)
        self.viewModel.select(index: indexPath.row)
    }
}

extension RepositoriesTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.repositoriesTableViewCell, for: indexPath)!
        let index = indexPath.row
        let data = dataSource[index]
        populateCell(index: index, repository: data, cell: cell)
        return cell
    }

    
}
