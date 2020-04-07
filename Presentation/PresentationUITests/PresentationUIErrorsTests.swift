//
//  PresentationUIErrorsTests.swift
//  PresentationUITests
//
//  Created by Victor C Tavernari on 05/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import XCTest
import SwiftLocalhost
import DataSource

class PresentationUIErrorTests: XCTestCase {

    var localhostServer: LocalhostServer!
//    var app: XCUIApplication!
    var portNumber: UInt!
    override func setUp() {
        continueAfterFailure = false
        self.localhostServer = LocalhostServer.initializeUsingRandomPortNumber()
        self.localhostServer.startListening()
        portNumber = self.localhostServer.portNumber
    }

    override func tearDown() {
        self.localhostServer.stopListening()
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

        self.localhostServer.get("/search/repositories", routeBlock: { _ in
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
        self.localhostServer.get("/search/repositories", routeBlock: { _ in
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
        XCTAssertTrue(app.alerts.element.exists)
    }

    func testErrorOnListOfPullRequests() {
        self.localhostServer.get("/search/repositories", routeBlock: { _ in
           let requestURL: URL = URL(string: "http://localhost:\(self.portNumber!)/search/repositories")!
           let httpUrlResponse = HTTPURLResponse(url: requestURL, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "application/json"])!
            let data = GithubRepositoryDataReponseFake.repositoriesData()
           return LocalhostServerResponse(httpUrlResponse: httpUrlResponse, data: data)
        })

        self.localhostServer.get("/repos/Tavernari/IOSArchitecture/pulls", routeBlock: { _ in
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
        self.localhostServer.get("/search/repositories", routeBlock: { _ in
           let requestURL: URL = URL(string: "http://localhost:\(self.portNumber!)/search/repositories")!
           let httpUrlResponse = HTTPURLResponse(url: requestURL, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "application/json"])!
            let data = GithubRepositoryDataReponseFake.repositoriesData()
           return LocalhostServerResponse(httpUrlResponse: httpUrlResponse, data: data)
        })

        self.localhostServer.get("/repos/Tavernari/IOSArchitecture/pulls", routeBlock: { _ in
           let requestURL: URL = URL(string: "http://localhost:\(self.portNumber!)/search/repositories")!
           let httpUrlResponse = HTTPURLResponse(url: requestURL, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "application/json"])!
            let data = GithubRepositoryDataReponseFake.listOfPullsData()
           return LocalhostServerResponse(httpUrlResponse: httpUrlResponse, data: data)
        })

        self.localhostServer.get("/repos/Tavernari/IOSArchitecture/pulls/1", routeBlock: { _ in
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
