//
//  FeedRefreshViewController.swift
//  EssentialFeediOS
//
//  Created by Maksim Khozyashev on 19.05.2023.
//

import UIKit
import EssentialFeed

final class FeedRefreshViewController: NSObject {
	public var onRefresh: (([FeedImage]) -> Void)?

	private(set) lazy var view: UIRefreshControl = {
		let view = UIRefreshControl()
		view.addTarget(self, action: #selector(refresh), for: .valueChanged)
		return view
	}()

	private let feedLoader: FeedLoader

	init(feedLoader: FeedLoader) {
		self.feedLoader = feedLoader
	}

	@objc func refresh() {
		view.beginRefreshing()
		feedLoader.load { [weak self] result in
			if let feed = try? result.get() {
				self?.onRefresh?(feed)
			}

			self?.view.endRefreshing()
		}
	}
}
