//
//  Login+initWithLoginData.swift
//  DataLayer
//
//  Created by Lucas Silveira on 07/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import DomainLayer

extension LoginModel {
    init(data: LoginDTO) {
        self.init()
        token = data.data.token
    }
}
