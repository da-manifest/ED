//
//  UIControl+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Maksim Khozyashev on 19.05.2023.
//

import UIKit

extension UIControl {
	func simulate(event: UIControl.Event) {
		allTargets.forEach { target in
			actions(forTarget: target, forControlEvent: event)?
				.forEach {
					(target as NSObject).perform(Selector($0))
				}
		}
	}
}
