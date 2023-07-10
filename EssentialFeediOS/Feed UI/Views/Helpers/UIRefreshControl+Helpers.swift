//
//  UIRefreshControl+Helpers.swift .swift
//  EssentialFeediOS
//
//  Created by Maksim Khozyashev on 10.07.2023.
//

import UIKit


extension UIRefreshControl {
	func update(isRefreshing: Bool) {
		isRefreshing ? beginRefreshing() : endRefreshing()
	}
}
