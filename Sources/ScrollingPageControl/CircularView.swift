//
//  CircularView.swift
//  ScrollingPageControl
//
//  Created by Emilio Peláez on 3/10/18.
//

import UIKit

class CircularView: UIView {
	override func tintColorDidChange() {
		self.backgroundColor = tintColor
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		updateCornerRadius()
	}
	
	override var frame: CGRect {
		didSet {
			updateCornerRadius()
		}
	}
	
	private func updateCornerRadius() {
		layer.cornerRadius = min(bounds.width, bounds.height) / 2
	}
}
