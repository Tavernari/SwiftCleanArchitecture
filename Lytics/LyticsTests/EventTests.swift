//
//  Lytics.swift
//  Lytics
//
//  Created by Victor C Tavernari on 07/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import XCTest
@testable import Lytics

class LyticsEventTests: XCTestCase {
    var mock: ProviderMock!

    override func setUpWithError() throws {
        Lytics.unregisterAllProviders()
        mock = ProviderMock(enable: true)
    }

    override func tearDownWithError() throws {
        XCTAssertGreaterThan(Lytics.providers.count, 0)
        Lytics.unregisterAllProviders()
    }

    func testSendEventWithProviderDisable() {
        mock.enable = false
        mock.eventValidation = { _ in
            XCTFail("Provider should be disabled")
        }

        try? Lytics.register(provider: mock)
        TestEvent.withoutData.dispatch()
    }

    func testSendEventWithoutData() throws {
        mock.eventValidation = {
            XCTAssertNil($0.data)
            XCTAssertEqual($0.name, "withoutData")
        }

        try? Lytics.register(provider: mock)

        TestEvent.withoutData.dispatch()
    }

    func testSendEventWithData() throws {
        let data = "TestData"
        mock.eventValidation = {
            XCTAssertEqual(($0.data!["data"] as! String), data)
            XCTAssertEqual($0.name, "withData")
        }

        try? Lytics.register(provider: mock)

        TestEvent.withData(data: data).dispatch()
    }
}
