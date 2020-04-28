//
//  APIErrorViewModelTests.swift
//  PresentationTests
//
//  Created by Victor C Tavernari on 05/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import DataLayer
import DomainLayer
@testable import PresentationLayer
import XCTest

class APIErrorViewModelTests: XCTestCase {
    func testCreateAndPressOk() {
        let errorMessage = "Error message"
        let viewModel = APIErrorViewModel(errorMessage: errorMessage)
        XCTAssertEqual(viewModel.message.value, errorMessage)
        viewModel.ok()
        XCTAssertEqual(viewModel.route.value, .ok)
    }
}
