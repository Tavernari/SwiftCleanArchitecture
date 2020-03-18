//
//  MainAssembler.swift
//  Presentation
//
//  Created by Victor C Tavernari on 18/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Swinject

class MainAssembler {
    private let assembler: Assembler
    var resolver: Resolver { assembler.resolver }
    init() {
        if ProcessInfo.processInfo.arguments.contains("ui-testing") {
            assembler = Assembler([GithubUITestWithDataAssembly()])
        } else {
            assembler = Assembler([GithubAssembly()])
        }
    }
}
