//
//  ListRepositories.swift
//  Domain
//
//  Created by Victor C Tavernari on 02/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation
import RxSwift

public class ListRepositories: UseCaseInput {
    typealias Output = [Repository]

    public enum Errors: Error {
        case needHandleCompletionResult
        case needSearchTerm
    }

    private var term: String?
    private let repository: GitRepoRepository

    public init(repository: GitRepoRepository) {
        self.repository = repository
    }

    public func with(input: String) -> Self {
        self.term = input
        return self
    }

    public func run() throws -> Observable<[Repository]> {
        guard let term = self.term else {
            throw ListRepositories.Errors.needSearchTerm
        }

        return self.repository.list(term: term)
    }
}
