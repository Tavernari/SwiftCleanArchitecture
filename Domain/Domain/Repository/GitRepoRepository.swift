//
//  RepoRepository.swift
//  Domain
//
//  Created by Victor C Tavernari on 04/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public protocol GitRepoRepository {
    func list(term:String, completion: @escaping (Result<[GitRepository], ListGitRepositoryUseCaseError>) -> Void)
}
