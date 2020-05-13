//
//  RegisterProviderTests.swift
//  AnalyticsTests
//
//  Created by Victor C Tavernari on 12/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import XCTest
@testable import Analytics

class RegisterProviderTests: XCTestCase {

    override func tearDown() {
        Lytics.removeAllMocks()
    }

    func testRegisterProvider() throws {
        let mock = ProviderMock(enable: true)
        Lytics.register(provider: mock)
        XCTAssertGreaterThan(Lytics.providers.count, 0)
    }
}
