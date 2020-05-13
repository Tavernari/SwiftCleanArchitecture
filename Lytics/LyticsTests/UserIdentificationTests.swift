//
//  UserIdentificationTests.swift
//  AnalyticsTests
//
//  Created by Victor C Tavernari on 12/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import XCTest
@testable import Analytics

class UserIdentificationTests: XCTestCase {

    override func setUpWithError() throws {
        Lytics.removeAllMocks()
    }

    override func tearDownWithError() throws {
        XCTAssertGreaterThan(Lytics.providers.count, 0)
        Lytics.removeAllMocks()
    }

    func testSendUserIdentificationWithProviderDisable() {
        let mock = ProviderMock(enable: false)
        mock.userIdentificationValidation = { (_, _, _) in
            XCTFail("Provider should be disabled")
        }

        Lytics.register(provider: mock)
        TestUserProperties.identify(id: "", name: nil, email: nil).dispatch()
    }

    func testSendOnlyUserIdData() throws {
        let idValue = "testId"
        let mock = ProviderMock(enable: true)
        mock.userIdentificationValidation = { (id: String?, name: String?, email: String?) in
            XCTAssertEqual(id, idValue)
            XCTAssertNil(name)
            XCTAssertNil(email)
        }

        Lytics.register(provider: mock)

        TestUserProperties.identify(id: idValue, name: nil, email: nil).dispatch()
    }

    func testSendOnlyUserNameData() throws {
        let nameValue = "testName"
        let mock = ProviderMock(enable: true)
        mock.userIdentificationValidation = { (id: String?, name: String?, email: String?) in
            XCTAssertEqual(name, nameValue)
            XCTAssertNil(id)
            XCTAssertNil(email)
        }

        Lytics.register(provider: mock)

        TestUserProperties.identify(id: nil, name: nameValue, email: nil).dispatch()
    }

    func testSendOnlyUserEmailData() throws {
        let emailValue = "testEmail"
        let mock = ProviderMock(enable: true)
        mock.userIdentificationValidation = { (id: String?, name: String?, email: String?) in
            XCTAssertEqual(email, emailValue)
            XCTAssertNil(id)
            XCTAssertNil(name)
        }

        Lytics.register(provider: mock)

        TestUserProperties.identify(id: nil, name: nil, email: emailValue).dispatch()
    }

    func testSendUserCompleteIdentificationData() throws {
        let emailValue = "emailValue"
        let nameValue = "nomeValue"
        let idValue = "idValue"
        let mock = ProviderMock(enable: true)
        mock.userIdentificationValidation = { (id: String?, name: String?, email: String?) in
            XCTAssertEqual(email, emailValue)
            XCTAssertEqual(name, nameValue)
            XCTAssertEqual(id, idValue)
        }

        Lytics.register(provider: mock)

        TestUserProperties.identify(id: idValue, name: nameValue, email: emailValue).dispatch()
    }

}
