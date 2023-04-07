//
//  ReverseWordsCodeUITests.swift
//  ReverseWordsCodeUITests
//
//  Created by Vladyslav Nhuien on 22.07.2022.
//

import XCTest

class ReverseWordsCodeUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }

    func testResult() throws {
        // given
        let input = app.textFields["Text to reverse"]
        let reverseButton = app.buttons["Reverse"]
        let result = app.textViews["olleH dlrow"]
        // then
        input.tap()
        input.typeText("Hello world")
        reverseButton.tap()
        
        XCTAssert(result.exists)
    }
    
    func testClearButton() throws {
        // given
        let input = app.textFields["Text to reverse"]
        let reverseButton = app.buttons["Reverse"]
        let clearButton = app.buttons["Clear"]
        // then
        input.tap()
        input.typeText("Hello world")
        reverseButton.tap()
        clearButton.tap()
        
        XCTAssert(reverseButton.exists)
    }
    
    func testInput() throws {
        // given
        let textField = app.textFields["Text to reverse"]
        let input = app.textFields["Test"]
        // then
        textField.tap()
        textField.typeText("Test")
        
        XCTAssert(input.exists)
    }
    
}
