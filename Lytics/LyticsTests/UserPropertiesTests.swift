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
        mock.enable = false
        mock.userPropertiesValidation = { _ in
            XCTFail("Provider should be disabled")
        }

        try? Lytics.register(provider: mock)
        TestUserProperties.isVip(true).dispatch()
    }

    fileprivate func mockResponse<Type: Equatable>(key: String, value: Type){
        mock.userPropertiesValidation = {
            let data = $0 as! [String: Type]
            XCTAssertEqual(data[key], value)
        }

        mock.userIdentificationValidation = { (_, _, _) in
            XCTFail()
        }

        try? Lytics.register(provider: mock)

    }

    func testSendUserIsVipData() throws {
        mockResponse(key:"isVip", value: true)
        TestUserProperties.isVip(true).dispatch()
    }

    func testSendUserIsVipFalseData() throws {
        mockResponse(key:"isVip", value: false)
        TestUserProperties.isVip(false).dispatch()
    }

    func testSendUserTotalCoin100Data() {
        mockResponse(key:"totalCoin", value: 100)
        TestUserProperties.totalCoin(100).dispatch()
    }

    func testSendUserTotalCoin0Data() {
        mockResponse(key:"totalCoin", value: 0)
        TestUserProperties.totalCoin(0).dispatch()
    }
}
