//
//  PresentationUIErrorsTests.swift
//  PresentationUITests
//
//  Created by Victor C Tavernari on 05/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import DataSource
import SwiftLocalhost
import XCTest

class PresentationUIErrorTests: XCTestCase {
    var localhostServer: LocalhostServer!
//    var app: XCUIApplication!
    var portNumber: UInt!
    override func setUp() {
        continueAfterFailure = false
        localhostServer = LocalhostServer.initializeUsingRandomPortNumber()
        localhostServer.startListening()
        portNumber = localhostServer.portNumber
    }

    override func tearDown() {
        localhostServer.stopListening()
    }

    func testListOfRepositoriesEmptyTerm() {
        let app = XCUIApplication()
        app.launchArguments.append("ui-testing")
        app.launchEnvironment["localhostPort"] = "\(portNumber!)"
        app.launchEnvironment["githubTerm"] = ""
        app.launch()
        let tablesQuery = app.tables
        sleep(1)
        XCTAssertEqual(tablesQuery.cells.count, 0)
        XCTAssertTrue(app.staticTexts["Term cannot be empty"].exists)
    }

    func testGithubErrorOnListOfRepositories() {
        localhostServer.get("/search/repositories", routeBlock: { _ in
            let requestURL: URL = URL(string: "http://localhost:\(self.portNumber!)/search/repositories")!
            let httpUrlResponse = HTTPURLResponse(url: requestURL, statusCode: 422, httpVersion: nil, headerFields: ["Content-Type": "application/json"])!
            let data = GithubRepositoryDataReponseFake.errorData(message: "invalid github")
            return LocalhostServerResponse(httpUrlResponse: httpUrlResponse, data: data)
        })

        let app = XCUIApplication()
        app.launchArguments.append("ui-testing")
        app.launchEnvironment["localhostPort"] = "\(portNumber!)"
        app.launch()
        let tablesQuery = app.tables
        sleep(1)
        XCTAssertEqual(tablesQuery.cells.count, 0)
        XCTAssertTrue(app.staticTexts["invalid github"].exists)
        app.buttons.firstMatch.tap()
        sleep(1)
        XCTAssertFalse(app.alerts.element.exists)
    }

    func testURLErrorOnListOfRepositories() {
        localhostServer.get("/search/repositories", routeBlock: { _ in
            let requestURL: URL = URL(string: "http://localhost:\(self.portNumber!)/search/repositories")!
            let httpUrlResponse = HTTPURLResponse(url: requestURL, statusCode: 504, httpVersion: nil, headerFields: ["Content-Type": "application/json"])!
            return LocalhostServerResponse(httpUrlResponse: httpUrlResponse, data: Data())
        })

        let app = XCUIApplication()
        app.launchArguments.append("ui-testing")
        app.launchEnvironment["localhostPort"] = "\(portNumber!)"
        app.launch()
        let tablesQuery = app.tables
        sleep(1)
        XCTAssertEqual(tablesQuery.cells.count, 0)
        XCTAssertFalse(app.alerts.element.exists)
    }

    func testErrorOnListOfPullRequests() {
        localhostServer.get("/search/repositories", routeBlock: { _ in
            let requestURL: URL = URL(string: "http://localhost:\(self.portNumber!)/search/repositories")!
            let httpUrlResponse = HTTPURLResponse(url: requestURL, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "application/json"])!
            let data = GithubRepositoryDataReponseFake.repositoriesData()
            return LocalhostServerResponse(httpUrlResponse: httpUrlResponse, data: data)
        })

        localhostServer.get("/repos/Tavernari/IOSArchitecture/pulls", routeBlock: { _ in
            let requestURL: URL = URL(string: "http://localhost:\(self.portNumber!)/search/repositories")!
            let httpUrlResponse = HTTPURLResponse(url: requestURL, statusCode: 504, httpVersion: nil, headerFields: ["Content-Type": "application/json"])!
            return LocalhostServerResponse(httpUrlResponse: httpUrlResponse, data: Data())
        })

        let app = XCUIApplication()
        app.launchArguments.append("ui-testing")
        app.launchEnvironment["localhostPort"] = "\(portNumber!)"
        app.launch()
        let tablesQuery = app.tables
        sleep(1)
        tablesQuery.cells.firstMatch.tap()
        sleep(1)
        XCTAssertEqual(tablesQuery.cells.count, 0)
        XCTAssertTrue(app.alerts.element.exists)
    }

    func testErrorOnPullRequestDetail() {
        localhostServer.get("/search/repositories", routeBlock: { _ in
            let requestURL: URL = URL(string: "http://localhost:\(self.portNumber!)/search/repositories")!
            let httpUrlResponse = HTTPURLResponse(url: requestURL, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "application/json"])!
            let data = GithubRepositoryDataReponseFake.repositoriesData()
            return LocalhostServerResponse(httpUrlResponse: httpUrlResponse, data: data)
        })

        localhostServer.get("/repos/Tavernari/IOSArchitecture/pulls", routeBlock: { _ in
            let requestURL: URL = URL(string: "http://localhost:\(self.portNumber!)/search/repositories")!
            let httpUrlResponse = HTTPURLResponse(url: requestURL, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "application/json"])!
            let data = GithubRepositoryDataReponseFake.listOfPullsData()
            return LocalhostServerResponse(httpUrlResponse: httpUrlResponse, data: data)
        })

        localhostServer.get("/repos/Tavernari/IOSArchitecture/pulls/1", routeBlock: { _ in
            let requestURL: URL = URL(string: "http://localhost:\(self.portNumber!)/search/repositories?q=swift")!
            let httpUrlResponse = HTTPURLResponse(url: requestURL, statusCode: 504, httpVersion: nil, headerFields: ["Content-Type": "application/json"])!
            return LocalhostServerResponse(httpUrlResponse: httpUrlResponse, data: Data())
        })

        let app = XCUIApplication()
        app.launchArguments.append("ui-testing")
        app.launchEnvironment["localhostPort"] = "\(portNumber!)"
        app.launch()
        let tablesQuery = app.tables
        sleep(1)
        tablesQuery.cells.firstMatch.tap()
        sleep(1)
        tablesQuery.cells.firstMatch.tap()
        sleep(1)
        XCTAssertEqual(tablesQuery.cells.count, 0)
        XCTAssertTrue(app.alerts.element.exists)
    }
}
