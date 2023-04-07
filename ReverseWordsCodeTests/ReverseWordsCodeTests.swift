//
//  ReverseWordsCodeTests.swift
//  ReverseWordsCodeTests
//
//  Created by Vladyslav Nhuien on 21.07.2022.
//

import XCTest
@testable import ReverseWordsCode

class ReverseWordsCodeTests: XCTestCase {
    
    var reverser: Reverser!

    override func setUpWithError() throws {
        try super.setUpWithError()
        reverser = Reverser()
    }

    override func tearDownWithError() throws {
        reverser = nil
        try super.tearDownWithError()
    }

    func testReverseWords() throws {
        let string = "Test string"
        let result = reverser.defaultReverse(textToReverse: string)
        XCTAssertEqual(result, "tseT gnirts")
    }
    
    func testReverseNumeral() throws {
        let string = "123465"
        let result = reverser.defaultReverse(textToReverse: string)
        XCTAssertEqual(result, "123465")
    }
    
    func testReverseSymbol() throws {
        let string = "@$!%(!@$*@#!"
        let result = reverser.defaultReverse(textToReverse: string)
        XCTAssertEqual(result, "@$!%(!@$*@#!")
    }
    
    func testReverseCyrillicWithRule() throws {
        let string = "Привет мир!"
        let ignore = "Привет"
        let result = reverser.reverseWithIgnoreRules(textToReverse: string, textToIgnore: ignore)
        XCTAssertEqual(result, "Привет !ирм")
    }
    
    func testReverseLongTextWithRule() throws {
        let string = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ultrices semper sapien vel semper. Maecenas egestas faucibus pellentesque. Nunc ornare diam a augue lobortis malesuada. Aliquam pulvinar eget mauris sit amet rutrum. Quisque dignissim tortor in justo dapibus lacinia. Donec."
        let rule = "r"
        let result = reverser.reverseWithIgnoreRules(textToReverse: string, textToIgnore: rule)
        XCTAssertEqual(result, "meroL muspi olodr tis ,tema utetcesnocr gnicsipida .tile nI secritlu epmesr neipas lev .epmers saneceaM satsege subicuaf .euqsetnellep cnuN eranro maid a eugua sitorbol .adauselam mauqilA anivlupr tege siuram tis tema r.mrutu euqsiuQ missingid otrotr ni otsuj subipad .ainical .cenoD")
    }
    
    func testReverseShortText() throws {
        let string = "La vi"
        let ignore = "Lavi"
        let result = reverser.reverseWithIgnoreRules(textToReverse: string, textToIgnore: ignore)
        XCTAssertEqual(result, "La vi")
    }
}
