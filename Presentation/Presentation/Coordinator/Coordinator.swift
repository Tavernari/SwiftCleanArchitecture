//
//  Coordinator.swift
//  Presentation
//
//  Created by Victor C Tavernari on 06/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    var childrens: [Coordinator] {get set}
    init(withNavigation navigationController: UINavigationController, assembler: MainAssembler)
    func start()
}
