//
//  GitRepoRepository.swift
//  DataSource
//
//  Created by Victor C Tavernari on 06/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Domain
import RxSwift
import Alamofire

public class GitRepoRepository: Domain.GitRepoRepository {

    private let dataSource: GitRepoDataSource
    public init(dataSource: GitRepoDataSource) {
        self.dataSource = dataSource
    }
    
    public func list(term: String) -> Observable<[GitRepository]> {
        return self.dataSource.list(term: term)
    }
}
