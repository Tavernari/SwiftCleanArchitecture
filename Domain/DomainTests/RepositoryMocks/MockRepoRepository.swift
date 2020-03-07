//
//  MockRepoRepository.swift
//  DomainTests
//
//  Created by Victor C Tavernari on 04/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation
import Domain

class MockRepoRepository: GitRepoRepository {

    private var result: [Repository]?
    private var error: Error?
    init(result: [Repository]?, error: Error?) {
        self.result = result
        self.error = error
    }
    func list(term: String, completionHandler: ([Repository]?, Error?) -> Void) {
        completionHandler(self.result, self.error)
    }
}
