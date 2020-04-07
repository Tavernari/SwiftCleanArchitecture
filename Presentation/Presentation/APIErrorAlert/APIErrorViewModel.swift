//
//  APIErrorViewModel.swift
//  Presentation
//
//  Created by Victor C Tavernari on 04/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Domain

class APIErrorViewModel: APIErrorViewModelInterface {

    var route = Observable<APIErrorViewModelRoute>(.none)
    var message = Observable<String>("")

    init(errorMessage: String) {
        self.message.value = errorMessage
    }

    func ok() {
        self.route.value = .ok
    }
}
