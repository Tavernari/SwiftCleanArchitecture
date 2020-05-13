//
//  AnalyticsTests.swift
//  AnalyticsTests
//
//  Created by Victor C Tavernari on 07/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import XCTest
@testable import Analytics

enum TestEvent: EventType {

    case withoutData
    case withData(data: String)

    var name: String {
        switch self {
        case .withData: return "withData"
        case .withoutData: return "withoutData"
        }
    }

    var data: [String : Any]? {
        switch self {
        case let .withData(data): return ["data": data]
        case .withoutData: return nil
        }
    }
}

class LyticsEventTests: XCTestCase {



    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
