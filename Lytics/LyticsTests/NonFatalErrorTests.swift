//
//  NonFatalErrorTests.swift
//  Lytics
//
//  Created by Victor C Tavernari on 13/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import XCTest
@testable import Lytics

class NonFatalErrorTests: XCTestCase {

    override func setUpWithError() throws {
        Lytics.unregisterAllProviders()
    }

    override func tearDownWithError() throws {
        XCTAssertGreaterThan(Lytics.providers.count, 0)
        Lytics.unregisterAllProviders()
    }

    func testSendCustomNonError(){
        let mock = ProviderMock()
        mock.errorValidation = { (error: Error, userInfo: [String: Any]?) in
            XCTAssertEqual(TestError.withoutUserInfo.localizedDescription, (error as! TestError).localizedDescription)
            XCTAssertNil(userInfo)

        }
        try? Lytics.register(provider: mock)
        TestError.withoutUserInfo.dispatch()
    }

    func testSendCustomNonErrorWithUserInfo(){
        let mock = ProviderMock()
        let userInfoValue: [String: Any] = ["test":"value"]
        mock.errorValidation = { (error: Error, userInfo: [String: Any]?) in
            XCTAssertEqual(TestError.withUserInfo(data: userInfo!).localizedDescription, (error as! TestError).localizedDescription)
            XCTAssertNotNil(userInfo)
            XCTAssertEqual(userInfo!["test"] as! String, userInfoValue["test"] as! String)

        }
        try? Lytics.register(provider: mock)
        TestError.withUserInfo(data: userInfoValue).dispatch()
    }

    func testSendSystemError() {
        let mock = ProviderMock()
        mock.errorValidation = { (error: Error, userInfo: [String: Any]?) in
            XCTAssertEqual(URLError(.dataNotAllowed), (error as! URLError))
            XCTAssertNil(userInfo)

        }
        try? Lytics.register(provider: mock)
        URLError(.dataNotAllowed).ly.dispatch()
    }

    func testSendSystemErrorWithAddtionarUserInfo() {
        let mock = ProviderMock()
        let userInfoValue: [String: Any] = ["test2":"value2"]
        mock.errorValidation = { (error: Error, userInfo: [String: Any]?) in
            XCTAssertEqual(URLError(.badURL), (error as! URLError))
            XCTAssertNil(userInfo!["test"])
            XCTAssertEqual(userInfo!["test2"] as! String, userInfoValue["test2"] as! String)

        }
        try? Lytics.register(provider: mock)
        URLError(.badURL).ly.dispatch(addtionalUserInfo: userInfoValue)
    }
}
