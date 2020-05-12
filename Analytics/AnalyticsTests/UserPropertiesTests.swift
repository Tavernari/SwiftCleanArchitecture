//
//  UserPropertiesTests.swift
//  AnalyticsTests
//
//  Created by Victor C Tavernari on 12/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//


import XCTest
@testable import Analytics

class UserPropertiesTests: XCTestCase {

    override func setUpWithError() throws {
        Lytics.removeAllMocks()
    }

    override func tearDownWithError() throws {
        XCTAssertGreaterThan(Lytics.providers.count, 0)
        Lytics.removeAllMocks()
    }

    func testSendUserPropertiesWithProviderDisable() {
        let mock = ProviderMock(enable: false)
        mock.userPropertiesValidation = { _ in
            XCTFail("Provider should be disabled")
        }

        Lytics.register(provider: mock)
        TestUserProperties.isVip(true).dispatch()
    }

    func testSendUserIsVipData() throws {
        let mock = ProviderMock(enable: true)
        mock.userPropertiesValidation = {
            let data = $0 as! [String: Bool]
            XCTAssertEqual(data["isVip"], true)
        }

        Lytics.register(provider: mock)

        TestUserProperties.isVip(true).dispatch()
    }

    func testSendUserIsVipFalseData() throws {
        let mock = ProviderMock(enable: true)
        mock.userPropertiesValidation = {
            let data = $0 as! [String: Bool]
            XCTAssertEqual(data["isVip"], false)
        }

        Lytics.register(provider: mock)

        TestUserProperties.isVip(false).dispatch()
    }

    func testSendUserTotalCoin100Data() throws {
        let totalCoin = 100
        let mock = ProviderMock(enable: true)
        mock.userPropertiesValidation = {
            let data = $0 as! [String: Int]
            XCTAssertEqual(data["totalCoin"], totalCoin)
        }

        Lytics.register(provider: mock)

        TestUserProperties.totalCoin(totalCoin).dispatch()
    }

    func testSendUserTotalCoin0Data() throws {
        let totalCoin = 0
        let mock = ProviderMock(enable: true)
        mock.userPropertiesValidation = {
            let data = $0 as! [String: Int]
            XCTAssertEqual(data["totalCoin"], totalCoin)
        }

        Lytics.register(provider: mock)

        TestUserProperties.totalCoin(totalCoin).dispatch()
    }
}
