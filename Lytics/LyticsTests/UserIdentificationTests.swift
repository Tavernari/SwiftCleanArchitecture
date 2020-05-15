//
//  UserIdentificationTests.swift
//  Lytics
//
//  Created by Victor C Tavernari on 12/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import XCTest
@testable import Lytics

class UserIdentificationTests: XCTestCase {

    var mock: ProviderMock!
    override func setUpWithError() throws {
        mock = ProviderMock(enable: true)
        Lytics.unregisterAllProviders()
    }

    override func tearDownWithError() throws {
        XCTAssertGreaterThan(Lytics.providers.count, 0)
        Lytics.unregisterAllProviders()
    }

    func testSendUserIdentificationWithProviderDisable() {
        mock.enable = false
        mock.userIdentificationValidation = { (_, _, _) in
            XCTFail("Provider should be disabled")
        }

        try? Lytics.register(provider: mock)
        TestUserProperties.identify(id: "", name: nil, email: nil).dispatch()
    }

    fileprivate func mockValidating(id:String? = nil, name:String? = nil, email: String? = nil) {
        mock.userIdentificationValidation = { (idValue: String?, nameValue: String?, emailValue: String?) in
            XCTAssertEqual(email, emailValue)
            XCTAssertEqual(id, idValue)
            XCTAssertEqual(name, nameValue)
        }

        mock.userPropertiesValidation = { (_) in
            XCTFail()
        }
    }

    func testSendOnlyUserIdData() throws {
        let idValue = "testId"
        mockValidating(id: idValue)
        try? Lytics.register(provider: mock)
        TestUserProperties.identify(id: idValue, name: nil, email: nil).dispatch()
    }

    func testSendOnlyUserNameData() throws {
        let nameValue = "testName"
        mockValidating(name: nameValue)
        try? Lytics.register(provider: mock)
        TestUserProperties.identify(id: nil, name: nameValue, email: nil).dispatch()
    }

    func testSendOnlyUserEmailData() throws {
        let emailValue = "testEmail"
        mockValidating(email: emailValue)
        try? Lytics.register(provider: mock)
        TestUserProperties.identify(id: nil, name: nil, email: emailValue).dispatch()
    }

    func testSendUserCompleteIdentificationData() throws {
        let emailValue = "emailValue"
        let nameValue = "nomeValue"
        let idValue = "idValue"
        mockValidating(id: idValue, name: nameValue, email: emailValue)
        try? Lytics.register(provider: mock)
        TestUserProperties.identify(id: idValue, name: nameValue, email: emailValue).dispatch()
    }
}
