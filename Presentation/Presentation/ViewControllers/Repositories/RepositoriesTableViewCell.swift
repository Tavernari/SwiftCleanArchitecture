//
//  RepositoriesTableViewCell.swift
//  Presentation
//
//  Created by Victor C Tavernari on 02/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class RepositoriesTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var repositoryImageView: UIImageView!
    @IBOutlet private weak var repositoryNameLabel: UILabel!
    @IBOutlet private weak var repositoryAuthorLabel: UILabel!
    @IBOutlet private weak var repositoryDescriptionLabel: UILabel!
    @IBOutlet private weak var repositoryStarCountLabel: UILabel!
    @IBOutlet private weak var repositoryForkCountLabel: UILabel!
    @IBOutlet private weak var repositoryIssueCountLabel: UILabel!

    public var repositoryImage: String? {
        didSet{

            guard let url = try? repositoryImage?.asURL() else {
                return
            }

            AF.request(url).responseImage { response in
                if case .success(let image) = response.result {
                    self.repositoryImageView.image = image.af.imageRoundedIntoCircle()
                }
            }
        }
    }

    public var repositoryName: String = "" { didSet { self.repositoryNameLabel.text = repositoryName } }
    public var repositoryAuthor: String = "" { didSet { self.repositoryAuthorLabel.text = repositoryAuthor } }
    public var repositoryDescription: String = "" { didSet { self.repositoryDescriptionLabel.text = repositoryDescription } }
    public var repositoryStarCount: String = "" { didSet { self.repositoryStarCountLabel.text = repositoryStarCount } }
    public var repositoryForkCount: String = "" { didSet { self.repositoryForkCountLabel.text = repositoryForkCount } }
    public var repositoryIssueCount: String = "" { didSet { self.repositoryIssueCountLabel.text = repositoryIssueCount } }

    override func awakeFromNib() {
        super.awakeFromNib()

        self.containerView.layer.shadowColor = UIColor.lightGray.cgColor
        self.containerView.layer.shadowOffset = .init(width: 3, height: 5)
        self.containerView.layer.shadowRadius = 5
        self.containerView.layer.shouldRasterize = true
        self.containerView.layer.rasterizationScale = UIScreen.main.scale
        self.containerView.layer.shadowOpacity = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
