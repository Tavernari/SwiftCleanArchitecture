//
//  UserPropertiesTests.swift
//  Lytics
//
//  Created by Victor C Tavernari on 12/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//


import XCTest
@testable import Lytics

class UserPropertiesTests: XCTestCase {

    var mock: ProviderMock!
    override func setUpWithError() throws {
        mock = ProviderMock(enable: true)
        Lytics.unregisterAllProviders()
    }

    override func tearDownWithError() throws {
        XCTAssertGreaterThan(Lytics.providers.count, 0)
        Lytics.unregisterAllProviders()
    }

    func testSendUserPropertiesWithProviderDisable() {
        mock.userPropertiesValidation = { _ in
            XCTFail("Provider should be disabled")
        }

        try? Lytics.register(provider: mock)
        TestUserProperties.isVip(true).dispatch()
    }

    fileprivate func mockIsVip(isVip: Bool){
        mock.userPropertiesValidation = {
            let data = $0 as! [String: Bool]
            XCTAssertEqual(data["isVip"], isVip)
        }

        mock.userIdentificationValidation = { (_, _, _) in
            XCTFail()
        }

        try? Lytics.register(provider: mock)

    }

    func testSendUserIsVipData() throws {
        mockIsVip(isVip: true)
        TestUserProperties.isVip(true).dispatch()
    }

    func testSendUserIsVipFalseData() throws {
        mockIsVip(isVip: false)
        TestUserProperties.isVip(false).dispatch()
    }

    fileprivate func mockTotalCoin(totalCoin: Int) {
        let mock = ProviderMock(enable: true)

        mock.userPropertiesValidation = {
            let data = $0 as! [String: Int]
            XCTAssertEqual(data["totalCoin"], totalCoin)
        }

        mock.userIdentificationValidation = { (_, _, _) in
            XCTFail()
        }

        try? Lytics.register(provider: mock)
    }

    func testSendUserTotalCoin100Data() {
        mockTotalCoin(totalCoin: 100)
        TestUserProperties.totalCoin(100).dispatch()
    }

    func testSendUserTotalCoin0Data() {
        mockTotalCoin(totalCoin: 0)
        TestUserProperties.totalCoin(0).dispatch()
    }
}
