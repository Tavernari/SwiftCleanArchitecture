//
//  ScreenEventsTests.swift
//  Lytics
//
//  Created by Victor C Tavernari on 12/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import XCTest
@testable import Lytics

class ScreenEventsTests: XCTestCase {

    override func setUpWithError() throws {
        Lytics.removeAllMocks()
    }

    override func tearDownWithError() throws {
        XCTAssertGreaterThan(Lytics.providers.count, 0)
        Lytics.removeAllMocks()
    }

    func testSendScreenEventWithProviderDisable() {
        let mock = ProviderMock(enable: false)
        mock.screenEventValidation = { _ in
            XCTFail("Provider should be disabled")
        }

        Lytics.register(provider: mock)
        TestScreenEvent.screenWithoutClass.dispatch()
    }

    func testSendScreenEventWithoutData() throws {
        let mock = ProviderMock(enable: true)
        mock.screenEventValidation = {
            XCTAssertNil($0.classValue)
            XCTAssertEqual($0.name, "screenWithoutClass")
        }

        Lytics.register(provider: mock)

        TestScreenEvent.screenWithoutClass.dispatch()
    }

    func testSendScreenEventWithData() throws {
        let mock = ProviderMock(enable: true)
        mock.screenEventValidation = {
            XCTAssertNotNil($0.classValue)
            XCTAssertEqual($0.name, "screenWithClass")
        }

        Lytics.register(provider: mock)

        TestScreenEvent.screenWithClass(class: UIViewController.self).dispatch()
    }
}
