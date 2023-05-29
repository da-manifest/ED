//
//  UITableView+Dequeueing.swift
//  EssentialFeediOS
//
//  Created by Maksim Khozyashev on 29.05.2023.
//

import UIKit

extension UITableView {
	func dequeueReusableCell<T: UITableViewCell>() -> T {
		dequeueReusableCell(withIdentifier: String(describing: T.self)) as! T
	}
}
