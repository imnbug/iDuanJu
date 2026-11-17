import UIKit
import XCTest
@testable import STV

final class PlatformChromeTests: XCTestCase {
    func testCapsuleMatchesLegacyIPhoneInset() {
        XCTAssertEqual(TabCapsuleLayout.bottomPadding(bottomInset: 34), -8)
        XCTAssertEqual(TabCapsuleLayout.contentClearance(bottomInset: 34), 72)
    }

    func testCapsuleStaysOnScreenWhenInsetIsZero() {
        XCTAssertEqual(TabCapsuleLayout.bottomPadding(bottomInset: 0), 26)
        XCTAssertEqual(TabCapsuleLayout.contentClearance(bottomInset: 0), 106)
    }

    func testInflatedInsetDoesNotDoubleCountClearance() {
        XCTAssertEqual(TabCapsuleLayout.bottomPadding(bottomInset: 83), -57)
        XCTAssertEqual(TabCapsuleLayout.contentClearance(bottomInset: 83), 23)
    }

    func testPlayerInsetsUseTheLargerReportedEdge() {
        let resolved = PlayerSafeArea.resolve(
            swift: EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0),
            window: UIEdgeInsets(top: 59, left: 10, bottom: 34, right: 10))
        XCTAssertEqual(resolved.top, 59)
        XCTAssertEqual(resolved.leading, 10)
        XCTAssertEqual(resolved.bottom, 34)
        XCTAssertEqual(resolved.trailing, 10)
    }

    func testPlayerInsetsKeepMatchingValues() {
        let resolved = PlayerSafeArea.resolve(
            swift: EdgeInsets(top: 59, leading: 0, bottom: 34, trailing: 0),
            window: UIEdgeInsets(top: 59, left: 0, bottom: 34, right: 0))
        XCTAssertEqual(resolved.top, 59)
        XCTAssertEqual(resolved.bottom, 34)
        XCTAssertEqual(resolved.leading, 0)
    }
}
