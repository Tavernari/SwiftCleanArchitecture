//
//  APIErrorViewModelInterface.swift
//  Presentation
//
//  Created by Victor C Tavernari on 04/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

protocol APIErrorViewModelInterface {
    var route: Observable<APIErrorViewModelRoute> { get }
    var message: Observable<String> { get }

    func ok()
}
