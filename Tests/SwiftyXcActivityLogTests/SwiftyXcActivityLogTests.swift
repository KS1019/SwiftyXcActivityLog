import XCTest
@testable import SwiftyXcActivityLog

final class SwiftyXcActivityLogTests: XCTestCase {
    
    // MARK: Testing for Extensions.swift
    func testUniqueElements() {
        let dupArray: [Int] = [1, 2, 3, 1, 2, 3]
        let noDupArray: [Int] = [1, 2, 3]
        XCTAssertEqual(dupArray.uniqueElements(noUnique: false), noDupArray)
    }

    func testReadByPattern() {
        let testString = """
0.01ms    /Users/testUser/Desktop/app-icon-resize-machine/app-icon-resize-machine/main.swift:19:16    setter configuration
"""
        XCTAssertTrue(testString.isReadableByPattern())
    }

    static var allTests = [
        ("testUniqueElements", testUniqueElements),
        ("testReadByPattern", testReadByPattern)
    ]
}
