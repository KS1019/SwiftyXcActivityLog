import XCTest
@testable import SwiftyXcActivityLog

final class SwiftyXcActivityLogTests: XCTestCase {
    
    // MARK: Testing for Extensions.swift
    func testUniqueElements() {
        let dupArray: [Int] = [1, 2, 3, 1, 2, 3]
        let noDupArray: [Int] = [1, 2, 3]
        XCTAssertEqual(dupArray.uniqueElements(noUnique: false), noDupArray)
    }

    func testIsReadableByPatternFunction() {
        XCTAssertTrue("0.01ms    /Users/testUser/Desktop/app-icon-resize-machine/app-icon-resize-machine/main.swift:19:16    setter configuration".isReadableByPattern())
        
        XCTAssertFalse("This sentence should not be readable by pattern".isReadableByPattern())
    }

    static var allTests = [
        ("testUniqueElements", testUniqueElements),
        ("testIsReadableByPatternFunction", testIsReadableByPatternFunction)
    ]
}
