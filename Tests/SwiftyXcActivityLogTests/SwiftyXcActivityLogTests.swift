import XCTest
@testable import SwiftyXcActivityLog

final class SwiftyXcActivityLogTests: XCTestCase {
    func testUniqueElements() {
        let dupArray: [Int] = [1, 2, 3, 1, 2, 3]
        let noDupArray: [Int] = [1, 2, 3]
        XCTAssertEqual(dupArray.uniqueElements(noUnique: false), noDupArray)
    }
    
    func testLibraryDir() {
        
    }

    static var allTests = [
        ("testUniqueElements", testUniqueElements)
    ]
}
