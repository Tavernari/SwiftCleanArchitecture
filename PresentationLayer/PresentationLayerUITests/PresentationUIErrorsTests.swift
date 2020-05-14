//
//  PresentationUIErrorsTests.swift
//  PresentationUITests
//
//  Created by Victor C Tavernari on 05/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import DataLayer
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
        localhostServer.githubGet(
            path: "/search/repositories",
            code: 422,
            data: GithubRepositoryDataReponseFake.errorData(message: "invalid github")
        )

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
        localhostServer.githubGet(path: "/search/repositories",
                                  code: 504,
                                  data: Data())

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
        localhostServer.githubGet(path: "/search/repositories",
                                  code: 200,
                                  data: GithubRepositoryDataReponseFake.repositoriesData())
        localhostServer.githubGet(path: "/repos/Tavernari/IOSArchitecture/pulls",
                                  code: 504,
                                  data: Data())

        let app = XCUIApplication()
        app.launchArguments.append("ui-testing")
        app.launchEnvironment["localhostPort"] = "\(portNumber!)"
        app.launch()
        sleep(2)
        let tablesQuery = app.tables
        sleep(1)
        tablesQuery.cells.firstMatch.tap()
        sleep(1)
        XCTAssertEqual(tablesQuery.cells.count, 0)
        XCTAssertTrue(app.alerts.element.exists)
    }

    func testErrorOnPullRequestDetail() {
        localhostServer.githubGet(path: "/search/repositories",
                                  code: 200,
                                  data: GithubRepositoryDataReponseFake.repositoriesData())
        localhostServer.githubGet(path: "/repos/Tavernari/IOSArchitecture/pulls",
                                  code: 200,
                                  data: GithubRepositoryDataReponseFake.listOfPullsData())
        localhostServer.githubGet(path: "/repos/Tavernari/IOSArchitecture/pulls/1",
                                  code: 504,
                                  data: Data())

        let app = XCUIApplication()
        app.launchArguments.append("ui-testing")
        app.launchEnvironment["localhostPort"] = "\(portNumber!)"
        app.launch()
        sleep(2)
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
