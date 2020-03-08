//
//  UIImageView+LoadCircleImage.swift
//  Presentation
//
//  Created by Victor C Tavernari on 08/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Alamofire
import AlamofireImage

extension UIImageView {
    func loadCircleImage(url: URL?, crossDissolveTime: Double = 0.3){

        guard let url = url else {
            return
        }

        self.af.setImage(
            withURL: url,
            filter: CircleFilter(),
            progressQueue: .main,
            imageTransition: .crossDissolve(crossDissolveTime),
            runImageTransitionIfCached: true)
    }
}
