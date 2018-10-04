//
//  ScrollingPageControl.swift
//  ScrollingPageControl
//
//  Created by Emilio Peláez on 3/10/18.
//

import UIKit

public protocol ScrollingPageControlDelegate: class {
	//	If delegate is nil or the implementation returns nil for a given dot, the default
	//	circle will be used. Returned views should react to having their tint color changed
	func viewForDot(at index: Int) -> UIView?
}

open class ScrollingPageControl: UIView {
	open weak var delegate: ScrollingPageControlDelegate? {
		didSet {
			createViews()
		}
	}
	//	The number of dots
	open var pages: Int = 0 {
		didSet {
			guard pages != oldValue else { return }
			pages = max(0, pages)
			invalidateIntrinsicContentSize()
			createViews()
		}
	}
	private func createViews() {
		dotViews = (0..<pages).map { index in
			delegate?.viewForDot(at: index) ?? CircularView(frame: CGRect(origin: .zero, size: CGSize(width: dotSize, height: dotSize)))
		}
	}
	//	The index of the currently selected page
	open var selectedPage: Int = 0 {
		didSet {
			guard selectedPage != oldValue else { return }
			selectedPage = max(0, min (selectedPage, pages - 1))
			updateColors()
			if (0..<centerDots).contains(selectedPage - pageOffset) {
				centerOffset = selectedPage - pageOffset
			} else {
				pageOffset = selectedPage - centerOffset
			}
		}
	}
	//	The maximum number of dots that will show in the control
	open var maxDots = 7 {
		didSet {
			maxDots = max(3, maxDots)
			if maxDots % 2 == 0 {
				maxDots += 1
				print("maxPages has to be an odd number")
			}
			invalidateIntrinsicContentSize()
			updatePositions()
		}
	}
	//	The number of dots that will be centered and full-sized
	open var centerDots = 3 {
		didSet {
			centerDots = max(1, centerDots)
			if centerDots % 2 == 0 {
				centerDots += 1
				print("centerDots has to be an odd number")
			}
			updatePositions()
		}
	}
	//	The duration, in seconds, of the dot slide animation
	open var slideDuration: TimeInterval = 0.15
	private var centerOffset = 0
	private var pageOffset = 0 {
		didSet {
			UIView.animate(withDuration: slideDuration, delay: 0.15, options: [], animations: self.updatePositions, completion: nil)
		}
	}
	
	private var dotViews: [UIView] = [] {
		didSet {
			oldValue.forEach { $0.removeFromSuperview() }
			dotViews.forEach(addSubview)
			updateColors()
			updatePositions()
		}
	}
	
	//	The color of all the unselected dots
	open var dotColor = UIColor.lightGray { didSet { updateColors() } }
	//	The color of the currently selected dot
	open var selectedColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) { didSet { updateColors() } }
	
	//	The size of the dots
	open var dotSize: CGFloat = 6 {
		didSet {
			dotSize = max(1, dotSize)
			dotViews.forEach { $0.frame = CGRect(origin: .zero, size: CGSize(width: dotSize, height: dotSize)) }
			updatePositions()
		}
	}
	//	The space between dots
	open var spacing: CGFloat = 4 {
		didSet {
			spacing = max(1, spacing)
			updatePositions()
		}
	}
	
	public init() {
		super.init(frame: .zero)
		isOpaque = false
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		isOpaque = false
	}
	
	private var lastSize = CGSize.zero
	open override func layoutSubviews() {
		super.layoutSubviews()
		guard bounds.size != lastSize else { return }
		lastSize = bounds.size
		updatePositions()
	}
	
	private func updateColors() {
		dotViews.enumerated().forEach { page, dot in
			dot.tintColor = page == selectedPage ? selectedColor : dotColor
		}
	}
	
	private func updatePositions() {
		let sidePages = (maxDots - centerDots) / 2
		let horizontalOffset = CGFloat(-pageOffset + sidePages) * (dotSize + spacing) + (bounds.width - intrinsicContentSize.width) / 2
		let centerPage = centerDots / 2 + pageOffset
		dotViews.enumerated().forEach { page, dot in
			let center = CGPoint(x: horizontalOffset + bounds.minX + dotSize / 2 + (dotSize + spacing) * CGFloat(page), y: bounds.midY)
			let scale: CGFloat = {
				let distance = abs(page - centerPage)
				if distance > (maxDots / 2) { return 0 }
				return [1, 0.66, 0.33, 0.16][max(0, min(3, distance - centerDots / 2))]
			}()
			dot.frame = CGRect(origin: .zero, size: CGSize(width: dotSize * scale, height: dotSize * scale))
			dot.center = center
		}
	}
	
	open override var intrinsicContentSize: CGSize {
		let pages = min(maxDots, self.pages)
		let width = CGFloat(pages) * dotSize + CGFloat(pages - 1) * spacing
		let height = dotSize
		return CGSize(width: width, height: height)
	}
}
