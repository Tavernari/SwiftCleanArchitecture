//
//  PresentationUITests.swift
//  PresentationUITests
//
//  Created by Victor C Tavernari on 02/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import XCTest

class PresentationUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false


    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShowListOfRepositories() {
        let app = XCUIApplication()
        app.launchArguments.append("ui-testing")
        app.launch()
        let tablesQuery = app.tables
        XCTAssertEqual(tablesQuery.cells.count, 2)
        XCTAssertTrue(app.staticTexts["ReSwiftMiddleware"].exists)
        XCTAssertTrue(app.staticTexts["Tavernari"].exists)
        XCTAssertTrue(app.staticTexts["IOSArchitecture"].exists)
    }

    func testNavigateToPullRequests() {
        let app = XCUIApplication()
        app.launchArguments.append("ui-testing")
        app.launch()
        let tablesQuery = app.tables
        tablesQuery.cells.firstMatch.tap()
        XCTAssertEqual(tablesQuery.cells.count, 1)
        XCTAssertTrue(app.staticTexts["Luis"].exists)
        XCTAssertTrue(app.staticTexts["Title of pull request"].exists)
        XCTAssertTrue(app.staticTexts["Description of pull request"].exists)
    }

    func testNavigateToPullRequestDetail() {
        let app = XCUIApplication()
        app.launchArguments.append("ui-testing")
        app.launch()
        let tablesQuery = app.tables
        tablesQuery.cells.firstMatch.tap()
        tablesQuery.cells.firstMatch.tap()
        XCTAssertTrue(app.staticTexts["Additions: 10"].exists)
        XCTAssertTrue(app.staticTexts["Commits: 30"].exists)
        XCTAssertTrue(app.staticTexts["Comments: 4"].exists)
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
