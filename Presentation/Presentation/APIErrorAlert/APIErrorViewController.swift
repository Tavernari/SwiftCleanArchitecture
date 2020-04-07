//
//  APIErrorViewController.swift
//  Presentation
//
//  Created by Victor C Tavernari on 04/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import UIKit

class APIErrorViewController: UIViewController {
    final class func initWith(withViewModel viewModel: APIErrorViewModel) -> APIErrorViewController {
        let vc = APIErrorViewController()
        vc.viewModel = viewModel
        return vc
    }

    var viewModel: APIErrorViewModelInterface!

    @IBOutlet private var messageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.bind(observable: viewModel.message)
    }

    @IBAction func ok() {
        viewModel.ok()
    }
}
