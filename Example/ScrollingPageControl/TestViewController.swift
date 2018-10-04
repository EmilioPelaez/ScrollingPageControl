//
//  ViewController.swift
//  ScrollingPageControl
//
//  Created by EmilioPelaez on 10/03/2018.
//  Copyright (c) 2018 EmilioPelaez. All rights reserved.
//

import UIKit
import ScrollingPageControl

class TestViewController: UIViewController {
	@IBOutlet var scrollView: UIScrollView!
	let stackView = UIStackView()
	
	@IBOutlet var pageControl: ScrollingPageControl!
	let pages: Int = 8
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		pageControl.pages = pages
		
		scrollView.isPagingEnabled = true
		view.addSubview(scrollView)
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.distribution = .fillEqually
		stackView.axis = .horizontal
		stackView.backgroundColor = .black
		
		scrollView.addSubview(stackView)
		
		(0..<pages).map { $0 % 2 == 0 ? UIColor.gray : UIColor.lightGray }.forEach { color in
			let item = UIView()
			item.translatesAutoresizingMaskIntoConstraints = false
			item.backgroundColor = color
			stackView.addArrangedSubview(item)
			item.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
		}
		
		stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
		stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
		stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
		stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
		stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
	}
	
}

extension TestViewController: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let page = round(scrollView.contentOffset.x / scrollView.frame.width)
		pageControl.selectedPage = Int(page)
	}
}
