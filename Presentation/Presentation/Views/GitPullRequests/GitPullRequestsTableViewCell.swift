//
//  GitPullRequestsTableViewCell.swift
//  Presentation
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class GitPullRequestsTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var pullRequestAuthorLabel: UILabel!
    @IBOutlet private weak var pullRequestTitleLabel: UILabel!
    @IBOutlet private weak var pullRequestDescriptionLabel: UILabel!
    @IBOutlet private weak var pullRequestDateLabel: UILabel!
    @IBOutlet private weak var pullRequestImageView: UIImageView!

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
        didSet{
            guard let url = try? pullRequestImage?.asURL() else {
                return
            }

            AF.request(url).responseImage { response in
                if case .success(let image) = response.result {
                    self.pullRequestImageView.image = image.af.imageRoundedIntoCircle()
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        self.containerView.layer.shadowColor = UIColor.lightGray.cgColor
        self.containerView.layer.shadowOffset = .init(width: 1, height: 1)
        self.containerView.layer.shadowRadius = 1
        self.containerView.layer.shouldRasterize = true
        self.containerView.layer.rasterizationScale = UIScreen.main.scale
        self.containerView.layer.shadowOpacity = 0.3
    }
}
