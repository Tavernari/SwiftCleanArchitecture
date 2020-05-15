//
//  UIView+defaultCardStyle.swift
//  PresentationLayer
//
//  Created by Victor C Tavernari on 15/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import UIKit

extension UIView {
    func defaultCardStyle() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = .init(width: 1, height: 1)
        layer.shadowRadius = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        layer.shadowOpacity = 0.3
    }
}
