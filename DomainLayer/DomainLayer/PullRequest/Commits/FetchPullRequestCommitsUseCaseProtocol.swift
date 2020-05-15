//
//  FetchCommitsUseCaseProtocol.swift
//  Domain
//
//  Created by Lucas Silveira on 23/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public protocol FetchPullRequestCommitsUseCaseProtocol {
    var delegateInterfaceAdapter: FetchPullRequestCommitsInterfaceAdapter? { get set }
    func execute(repoName: String, ownerName: String)
}

// public enum FetchCommitsUseCaseError: Error {
//    case unknowReason
// }

public protocol FetchPullRequestCommitsInterfaceAdapter {
    func doing()
    func done(data: [GitCommitModel])
    func failure(error: Error)
}

public class FetchPullRequestCommitsUseCase: FetchPullRequestCommitsUseCaseProtocol {
    public var delegateInterfaceAdapter: FetchPullRequestCommitsInterfaceAdapter?

    private let repository: GitPullRequestRepositoryProtocol

    public init(respository: GitPullRequestRepositoryProtocol) {
        repository = respository
    }

    public func execute(repoName: String, ownerName: String) {
        delegateInterfaceAdapter?.doing()
        repository.commits(repoName: repoName, owner: ownerName) { result in
            do {
                self.delegateInterfaceAdapter?.done(data: try result.handle())
            } catch {
                self.delegateInterfaceAdapter?.failure(error: error)
            }
        }
    }
}
