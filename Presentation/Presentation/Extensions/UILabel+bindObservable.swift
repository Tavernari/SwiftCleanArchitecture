//
//  UILabel+bindObservable.swift
//  Presentation
//
//  Created by Victor C Tavernari on 04/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import UIKit

extension UILabel {
    func bind(observable: Observable<String>) {
        observable.observe { message in
            self.text = message
        }
    }
}
