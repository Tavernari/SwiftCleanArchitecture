//
//  FetchCommitsUseCaseProtocol.swift
//  Domain
//
//  Created by Lucas Silveira on 23/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public protocol FetchCommitsUseCaseProtocol {
    var delegateInterfaceAdapter: FetchCommitsInterfaceAdapter? { get set }
    func execute(repoName: String, ownerName: String)
}

// public enum FetchCommitsUseCaseError: Error {
//    case unknowReason
// }

public protocol FetchCommitsInterfaceAdapter {
    func doing()
    func done(data: [GitCommit])
    func failure(error: Error)
}

public class FetchCommitsUseCase: FetchCommitsUseCaseProtocol {
    public var delegateInterfaceAdapter: FetchCommitsInterfaceAdapter?

    private let repository: GitCommitsPullRequestProtocol

    public init(respository: GitCommitsPullRequestProtocol) {
        repository = respository
    }

    public func execute(repoName: String, ownerName: String) {
        delegateInterfaceAdapter?.doing()
        repository.list(repoName: repoName, prOwner: ownerName) { result in
            do {
                let commits = try result.handle()
                self.delegateInterfaceAdapter?.done(data: commits)
            } catch { self.delegateInterfaceAdapter?.failure(error: error) }
        }
    }
}
