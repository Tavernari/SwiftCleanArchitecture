//
//  RegisterProviderTests.swift
//  Lytics
//
//  Created by Victor C Tavernari on 12/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import XCTest
@testable import Lytics

class RegisterProviderTests: XCTestCase {

    override func tearDown() {
        Lytics.unregisterAllProviders()
    }

    func testRegisterProvider() throws {
        let mock = ProviderMock(enable: true)
        try? Lytics.register(provider: mock)
        XCTAssertGreaterThan(Lytics.providers.count, 0)
    }

    func testUnregisterProvider() {
        let mock = ProviderMock(enable: true)
        try? Lytics.register(provider: mock)
        XCTAssertEqual(Lytics.providers.count, 1)
        Lytics.unregister(provider: mock)
        XCTAssertEqual(Lytics.providers.count, 0)
    }

    func testRegisterTwiceProviderShouldThrowException() {
        let mock = ProviderMock(enable: true)
        try? Lytics.register(provider: mock)
        XCTAssertThrowsError(try Lytics.register(provider: mock))
    }

    func testUnregisterAllProviders() {
        let mock1 = ProviderMock(enable: true, name: "mock1")
        let mock2 = ProviderMock(enable: true, name: "mock2")
        let mock3 = ProviderMock(enable: true, name: "mock3")
        try? Lytics.register(provider: mock1)
        try? Lytics.register(provider: mock2)
        try? Lytics.register(provider: mock3)
        XCTAssertEqual(Lytics.providers.count, 3)
        Lytics.unregisterAllProviders()
        XCTAssertEqual(Lytics.providers.count, 0)
    }
}
