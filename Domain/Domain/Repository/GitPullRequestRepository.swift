//
//  GitPullRequestRepository.swift
//  Domain
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import RxSwift

public protocol GitPullRequestRepository {
    func list(owner: String, onRepository repository: String) -> Observable<[GitPullRequest]>
}
