import XCTest
@testable import ScrollingPageControl

class Tests: XCTestCase {
	
	func testLayout() {
		(1..<10).forEach { a in
			(1..<10).forEach { b in
				(1..<10).forEach { c in
					evaluatePageControl(pages: a, centerDots: b, maxDots: c)
				}
			}
		}
	}
	
	func evaluatePageControl(pages: Int, centerDots: Int, maxDots: Int) {
		let pageControl = ScrollingPageControl()
		pageControl.pages = pages
		pageControl.centerDots = centerDots
		pageControl.maxDots = maxDots
		
		pageControl.frame = CGRect(origin: .zero, size: pageControl.intrinsicContentSize)
		pageControl.updatePositions()
		
		XCTAssertGreaterThanOrEqual(pageControl.bounds.width, CGFloat(min(pageControl.pages, pageControl.maxDots)) * pageControl.dotSize)
		XCTAssertEqual(pageControl.dotViews.count, pageControl.pages)
		
		let fullSizeDots = pageControl.dotViews.filter { $0.frame.width == pageControl.dotSize }.count
		XCTAssertLessThanOrEqual(fullSizeDots, pageControl.centerDots)
		
		let visibleDots = pageControl.dotViews.filter { pageControl.bounds.contains($0.frame) }.count
		XCTAssertLessThanOrEqual(visibleDots, max(pageControl.maxDots, pageControl.pages))
	}
	
}
