//
//  GitRepositoriesTableViewCell.swift
//  Presentation
//
//  Created by Victor C Tavernari on 02/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Alamofire
import AlamofireImage
import UIKit

class GitRepositoriesTableViewCell: UITableViewCell {
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var repositoryImageView: UIImageView!
    @IBOutlet private var repositoryNameLabel: UILabel!
    @IBOutlet private var repositoryAuthorLabel: UILabel!
    @IBOutlet private var repositoryDescriptionLabel: UILabel!
    @IBOutlet private var repositoryStarCountLabel: UILabel!
    @IBOutlet private var repositoryForkCountLabel: UILabel!
    @IBOutlet private var repositoryIssueCountLabel: UILabel!

    @IBOutlet private var repositoryReliabilityIndicatorContainer: UIStackView!
    @IBOutlet private var repositoryReliabilityIndicatorLabel: UILabel!

    public var repositoryImage: String? {
        didSet {
            if let url = try? repositoryImage!.asURL() {
                repositoryImageView.loadCircleImage(url: url)
            }
        }
    }

    public var repositoryName: String = "" { didSet { self.repositoryNameLabel.text = repositoryName } }
    public var repositoryAuthor: String = "" { didSet { self.repositoryAuthorLabel.text = repositoryAuthor } }
    public var repositoryDescription: String = "" { didSet { self.repositoryDescriptionLabel.text = repositoryDescription } }
    public var repositoryStarCount: String = "" { didSet { self.repositoryStarCountLabel.text = repositoryStarCount } }
    public var repositoryForkCount: String = "" { didSet { self.repositoryForkCountLabel.text = repositoryForkCount } }
    public var repositoryIssueCount: String = "" { didSet { self.repositoryIssueCountLabel.text = repositoryIssueCount } }
    public var repositoryReliabilityIndicator: String = "" { didSet { self.repositoryReliabilityIndicatorLabel.text = repositoryReliabilityIndicator } }

    public var repositoryReliabilityIndicatorEnabled = false {
        didSet {
            if repositoryReliabilityIndicatorEnabled == false {
                if let parent = self.repositoryReliabilityIndicatorContainer.superview as? UIStackView {
                    parent.removeArrangedSubview(self.repositoryReliabilityIndicatorContainer)
                    self.repositoryReliabilityIndicatorContainer.removeFromSuperview()
                    parent.updateConstraints()
                }
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
