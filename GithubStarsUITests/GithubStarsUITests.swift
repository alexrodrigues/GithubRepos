//
//  GithubStarsUITests.swift
//  GithubStarsUITests
//
//  Created by Alex Rodrigues on 29/01/19.
//  Copyright © 2019 Alex Rodrigues. All rights reserved.
//

import XCTest

class GithubStarsUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
    }

    func testScroll() {
        let exp = expectation(description: "Waiting Screen wake up")
        _ = XCTWaiter.wait(for: [exp], timeout: 4.0)
        let table = app.tables["HomeTableView"]
        table.swipeDown()
        table.swipeUp()
    }
}
