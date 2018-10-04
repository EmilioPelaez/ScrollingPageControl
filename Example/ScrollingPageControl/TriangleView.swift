//
//  TriangleView.swift
//  ScrollingPageControl_Example
//
//  Created by Emilio Peláez on 4/10/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class TriangleView: UIView {
	
	override func tintColorDidChange() {
		super.tintColorDidChange()
		setNeedsDisplay()
	}
	
	override func draw(_ rect: CGRect) {
		let path = UIBezierPath()
		path.move(to: CGPoint(x: rect.midX, y: rect.minY))
		path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
		path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
		path.close()
		
		tintColor?.setFill()
		path.fill()
	}
	
}
