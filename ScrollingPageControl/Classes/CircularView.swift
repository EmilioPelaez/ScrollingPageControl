//
//  CircularView.swift
//  ScrollingPageControl
//
//  Created by Emilio Peláez on 3/10/18.
//

import UIKit

class CircularView: UIView {
	override func layoutSubviews() {
		super.layoutSubviews()
		layer.cornerRadius = min(frame.width, frame.height) / 2
	}
}
