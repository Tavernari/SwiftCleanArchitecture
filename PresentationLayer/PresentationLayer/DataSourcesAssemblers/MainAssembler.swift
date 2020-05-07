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
        assembler = Assembler([DataSourceAssembler()])

        print("MainAssembler \(AppLaunchArguments.uiTesting.exist)")

        if AppLaunchArguments.uiTesting.exist {
            assembler.apply(assembly: UITestRemoteConfigAssembly())
        } else {
            assembler.apply(assembly: RemoteConfigAssembly())
        }
    }
}
