//
//  GitRepoRepositoryInterface.swift
//  Domain
//
//  Created by Victor C Tavernari on 04/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
public protocol GitRepoRepositoryInterface {
    func list(term: String, completion: @escaping (Result<[GitRepository], Error>) -> Void)
}
