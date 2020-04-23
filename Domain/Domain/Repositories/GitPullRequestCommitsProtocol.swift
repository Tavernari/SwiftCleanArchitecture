//
//  GitCommitsPullRequestProtocol.swift
//  Domain
//
//  Created by Lucas Silveira on 23/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public protocol GitPullRequestCommitsProtocol {
    func list(repoName: String, prOwner: String, completion: @escaping (Result<[GitCommit], Error>) -> Void)
}
