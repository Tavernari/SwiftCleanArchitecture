//
//  GitPullRequestsTableViewCell.swift
//  Presentation
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Alamofire
import AlamofireImage
import UIKit

class GitPullRequestsTableViewCell: UITableViewCell {
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var pullRequestAuthorLabel: UILabel!
    @IBOutlet private var pullRequestTitleLabel: UILabel!
    @IBOutlet private var pullRequestDescriptionLabel: UILabel!
    @IBOutlet private var pullRequestDateLabel: UILabel!
    @IBOutlet private var pullRequestImageView: UIImageView!

    public var pullRequestAuthor: String = "" {
        didSet {
            pullRequestAuthorLabel.text = pullRequestAuthor
        }
    }

    public var pullRequestTitle: String = "" {
        didSet {
            pullRequestTitleLabel.text = pullRequestTitle
        }
    }

    public var pullRequestDescription: String = "" {
        didSet {
            pullRequestDescriptionLabel.text = pullRequestDescription
        }
    }

    public var pullRequestDate: String = "" {
        didSet {
            pullRequestDateLabel.text = pullRequestDate
        }
    }

    public var pullRequestImage: String? {
        didSet {
            if let url = try? pullRequestImage?.asURL() {
                self.pullRequestImageView.loadCircleImage(url: url)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        containerView.layer.shadowColor = UIColor.lightGray.cgColor
        containerView.layer.shadowOffset = .init(width: 1, height: 1)
        containerView.layer.shadowRadius = 1
        containerView.layer.shouldRasterize = true
        containerView.layer.rasterizationScale = UIScreen.main.scale
        containerView.layer.shadowOpacity = 0.3
    }
}
