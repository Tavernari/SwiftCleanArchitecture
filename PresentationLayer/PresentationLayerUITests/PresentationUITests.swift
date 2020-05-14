//
//  PresentationUITests.swift
//  PresentationUITests
//
//  Created by Victor C Tavernari on 02/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import DataLayer
import SwiftLocalhost
import XCTest

class PresentationUITests: XCTestCase {
    var localhostServer: LocalhostServer!
    var app: XCUIApplication!
//    var app: XCUIApplication!
    var portNumber: UInt!
    override func setUp() {
        continueAfterFailure = false
        localhostServer = LocalhostServer.initializeUsingRandomPortNumber()
        localhostServer.startListening()
        portNumber = localhostServer.portNumber

        localhostServer.githubGet(path: "/search/repositories",
                                  code: 200,
                                  data: GithubRepositoryDataReponseFake.repositoriesData())
        localhostServer.githubGet(path: "/repos/Tavernari/IOSArchitecture/pulls",
                                  code: 200,
                                  data: GithubRepositoryDataReponseFake.listOfPullsData())
        localhostServer.githubGet(path: "/repos/Tavernari/IOSArchitecture/pulls/1",
                                  code: 200,
                                  data: GithubRepositoryDataReponseFake.pullDetailData())

        app = XCUIApplication()
        app.launchArguments.append(AppLaunchArguments.uiTesting.rawValue)
        app.launchEnvironment[AppEnvironment.localhostPort.rawValue] = "\(portNumber!)"
    }

    override func tearDown() {
        localhostServer.stopListening()
    }

    func testDisableReliabilityScoreWithMultiplier() {
        app.launchEnvironment[AppEnvironment.configReliabilityEnable.rawValue] = "0"
        app.launch()
        sleep(1)
        XCTAssertFalse(app.images["RepositoryTableViewCell.ReliabilityIcon"].exists)
    }

    func testEnableReliabilityScoreWithMultiplier() {
        app.launchEnvironment[AppEnvironment.configReliabilityEnable.rawValue] = "1"
        app.launchEnvironment[AppEnvironment.configReliabilityMultipler.rawValue] = "1.0"
        app.launch()
        sleep(1)
        XCTAssertTrue(app.images["RepositoryTableViewCell.ReliabilityIcon"].exists)
    }

    func testShowListOfRepositories() {
        app.launch()
        let tablesQuery = app.tables
        sleep(2)
        XCTAssertEqual(tablesQuery.cells.count, 2)
        XCTAssertTrue(app.staticTexts["ReSwiftMiddleware"].exists)
        XCTAssertTrue(app.staticTexts["Tavernari"].exists)
        XCTAssertTrue(app.staticTexts["IOSArchitecture"].exists)
    }

    func testNavigateToPullRequests() {
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
}
