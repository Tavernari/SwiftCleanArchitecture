//
//  UIViewController+showError.swift
//  PresentationLayer
//
//  Created by Victor C Tavernari on 15/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import UIKit

extension UIViewController {
    func showError(message: String?) {
        guard let message = message else {
            return
        }

        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
