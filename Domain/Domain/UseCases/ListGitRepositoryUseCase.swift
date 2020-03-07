//
//  ListRepositories.swift
//  Domain
//
//  Created by Victor C Tavernari on 02/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation
import RxSwift

public protocol ListGitRepositoryUseCase {
    func execute(term: String) -> Observable<[Repository]>
}

public class DoListGitRepositoryUseCase: ListGitRepositoryUseCase {
    private let repository: GitRepoRepository

    public init(repository: GitRepoRepository) {
        self.repository = repository
    }

    public func execute(term: String) -> Observable<[Repository]> {
        return self.repository.listUsing(term: term)
    }
}
