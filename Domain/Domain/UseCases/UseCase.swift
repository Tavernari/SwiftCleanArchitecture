//
//  UseCase.swift
//  Domain
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import RxSwift

protocol UseCase {
    associatedtype Output
    func run() throws -> Observable<Output>
}
