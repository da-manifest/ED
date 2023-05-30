//
//  UIRefreshControl+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Maksim Khozyashev on 19.05.2023.
//

import UIKit

extension UIRefreshControl {
	func simulatePullToRefresh() {
		simulate(event: .valueChanged)
	}
}
