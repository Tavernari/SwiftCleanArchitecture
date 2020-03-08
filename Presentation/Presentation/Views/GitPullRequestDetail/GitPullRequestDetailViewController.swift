//
//  GitPullRequestDetailViewController.swift
//  Presentation
//
//  Created by Victor C Tavernari on 08/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import UIKit
import Domain
import Alamofire
import AlamofireImage

class GitPullRequestDetailViewController: UIViewController {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var commentsLabel: UILabel!
    @IBOutlet private weak var commitsLabel: UILabel!
    @IBOutlet private weak var additionsLabel: UILabel!
    @IBOutlet private weak var deletionsLabel: UILabel!
    @IBOutlet private weak var changedFilesLabel: UILabel!

    final class func initWith(viewModel: GitPullRequestDetailViewModel, id: Int, repo: GitRepository) -> GitPullRequestDetailViewController {
        let vc = GitPullRequestDetailViewController()
        vc.viewModel = viewModel
        vc.id = id
        vc.repo = repo
        return vc
    }

    private(set) var viewModel: GitPullRequestDetailViewModel!
    private(set) var id: Int!
    private(set) var repo: GitRepository!

    fileprivate func populateView(data: GitPullRequest) {
        self.titleLabel.text = data.title
        self.authorLabel.text = data.author
        self.descriptionLabel.text = data.description
        self.commitsLabel.text = "Commits: \(data.commitsCount)"
        self.commentsLabel.text = "Comments: \(data.commentsCount)"
        self.additionsLabel.text = "Additions: \(data.additionsCount)"
        self.deletionsLabel.text = "Deletions: \(data.deletionsCount)"
        self.changedFilesLabel.text = "Changed Files: \(data.changedFilesCount)"
        self.dateLabel.text = data.date?.string(format: .ddMMyyyyHHmmss) ?? ""
        self.imageView.loadCircleImage(url: try? data.image.asURL())
    }

    fileprivate func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    fileprivate func handleStatus(status: ViewModelLoadStatus) {
        switch status {
        case .loading:
            self.containerView.isHidden = true
            self.showLoadingIndicator(text: "Loading")
        case .loaded:
            self.containerView.isHidden = false
            self.removeLoadingIndicator()
        case .fail(let errorMessage):
            self.removeLoadingIndicator()
            self.showError(message: errorMessage)
        case .none:
            self.removeLoadingIndicator()
            self.containerView.isHidden = true
        }
    }

    fileprivate func bindToViewModel() {
        self.viewModel.status.observe(listener: self.handleStatus)
        self.viewModel.pullRequest.observe(listener: self.populateView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pull Request Detail"
        bindToViewModel()
        viewModel.load(data: GitPullRequestDetailViewModelInputData(repo: repo, id: id))
    }
}
