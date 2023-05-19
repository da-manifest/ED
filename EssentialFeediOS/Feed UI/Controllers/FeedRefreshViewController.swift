//
//  FeedRefreshViewController.swift
//  EssentialFeediOS
//
//  Created by Maksim Khozyashev on 19.05.2023.
//

import UIKit

final class FeedRefreshViewController: NSObject, FeedLoadingView {
	private(set) lazy var view = loadView()

	private let presenter: FeedPresenter

	init(feedPresenter: FeedPresenter) {
		self.presenter = feedPresenter
	}

	@objc func refresh() {
		presenter.loadFeed()
	}

	func display(_ viewModel: FeedLoadingViewModel) {
		if viewModel.isLoading {
			view.beginRefreshing()
		} else {
			view.endRefreshing()
		}
	}

	private func loadView() -> UIRefreshControl {
		let view = UIRefreshControl()
		view.addTarget(self, action: #selector(refresh), for: .valueChanged)
		return view
	}
}
