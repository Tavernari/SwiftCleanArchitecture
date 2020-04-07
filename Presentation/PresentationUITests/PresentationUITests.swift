//
//  PresentationUITests.swift
//  PresentationUITests
//
//  Created by Victor C Tavernari on 02/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import XCTest
import SwiftLocalhost
import DataSource

class PresentationUITests: XCTestCase {

    var localhostServer: LocalhostServer!
//    var app: XCUIApplication!
    var portNumber: UInt!
    override func setUp() {
        continueAfterFailure = false
        self.localhostServer = LocalhostServer.initializeUsingRandomPortNumber()
        self.localhostServer.startListening()
        portNumber = self.localhostServer.portNumber

        self.localhostServer.get("/search/repositories", routeBlock: { _ in
            let requestURL: URL = URL(string: "http://localhost:\(self.portNumber!)/search/repositories?q=swift")!
            let httpUrlResponse = HTTPURLResponse(url: requestURL, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "application/json"])!
            let data = GithubRepositoryDataReponseFake.repositoriesData()
            return LocalhostServerResponse(httpUrlResponse: httpUrlResponse, data: data)
        })

        self.localhostServer.get("/repos/Tavernari/IOSArchitecture/pulls", routeBlock: { _ in
            let requestURL: URL = URL(string: "http://localhost:\(self.portNumber!)/search/repositories?q=swift")!
            let httpUrlResponse = HTTPURLResponse(url: requestURL, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "application/json"])!
            let data = GithubRepositoryDataReponseFake.listOfPullsData()
            return LocalhostServerResponse(httpUrlResponse: httpUrlResponse, data: data)
        })

        self.localhostServer.get("/repos/Tavernari/IOSArchitecture/pulls/1", routeBlock: { _ in
            let requestURL: URL = URL(string: "http://localhost:\(self.portNumber!)/search/repositories?q=swift")!
            let httpUrlResponse = HTTPURLResponse(url: requestURL, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "application/json"])!
            let data = GithubRepositoryDataReponseFake.pullDetailData()
            return LocalhostServerResponse(httpUrlResponse: httpUrlResponse, data: data)
        })
    }

    override func tearDown() {
        self.localhostServer.stopListening()
    }

    func testShowListOfRepositories() {

        let app = XCUIApplication()
        app.launchArguments.append("ui-testing")
        app.launchEnvironment["localhostPort"] = "\(portNumber!)"
        app.launch()
        let tablesQuery = app.tables
        sleep(1)
        XCTAssertEqual(tablesQuery.cells.count, 2)
        XCTAssertTrue(app.staticTexts["ReSwiftMiddleware"].exists)
        XCTAssertTrue(app.staticTexts["Tavernari"].exists)
        XCTAssertTrue(app.staticTexts["IOSArchitecture"].exists)
    }

    func testNavigateToPullRequests() {
        let app = XCUIApplication()
        app.launchArguments.append("ui-testing")
        app.launchEnvironment["localhostPort"] = "\(portNumber!)"
        app.launch()
        let tablesQuery = app.tables
        tablesQuery.cells.firstMatch.tap()
        sleep(1)
        XCTAssertEqual(tablesQuery.cells.count, 1)
        XCTAssertTrue(app.staticTexts["Luis"].exists)
        XCTAssertTrue(app.staticTexts["Title of pull request"].exists)
        XCTAssertTrue(app.staticTexts["Description of pull request"].exists)
    }

    func testNavigateToPullRequestDetail() {
        let app = XCUIApplication()
        app.launchArguments.append("ui-testing")
        app.launchEnvironment["localhostPort"] = "\(portNumber!)"
        app.launch()
        let tablesQuery = app.tables
        tablesQuery.cells.firstMatch.tap()
        sleep(1)
        tablesQuery.cells.firstMatch.tap()
        sleep(1)
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
