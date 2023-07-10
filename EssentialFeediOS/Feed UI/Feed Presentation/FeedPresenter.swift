//
//  FeedPresenter.swift
//  EssentialFeediOS
//
//  Created by Maksim Khozyashev on 19.05.2023.
//

import EssentialFeed

protocol FeedLoadingView {
	func display(_ viewModel: FeedLoadingViewModel)
}

protocol FeedView {
	func display(_ viewModel: FeedViewModel)
}

final class FeedPresenter {
	typealias Observer<T> = (T) -> Void

	static var title: String {
		NSLocalizedString("FEED_VIEW_TITLE",
						  tableName: "Feed",
						  bundle: Bundle(for: FeedPresenter.self),
						  comment: "Title for the feed view")
	}

	private let feedView: FeedView
	private let loadingView: FeedLoadingView

	init(feedView: FeedView, loadingView: FeedLoadingView) {
		self.feedView = feedView
		self.loadingView = loadingView
	}

	func didStartLoadingFeed() {
		guard Thread.isMainThread else {
			return DispatchQueue.main.async { [weak self] in
				self?.didStartLoadingFeed()
			}
		}

		loadingView.display(FeedLoadingViewModel(isLoading: true))
	}

	func didFinishLoadingFeed(with feed: [FeedImage]) {
		guard Thread.isMainThread else {
			return DispatchQueue.main.async { [weak self] in
				self?.didFinishLoadingFeed(with: feed)
			}
		}

		feedView.display(FeedViewModel(feed: feed))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}

	func didFinishLoadingFeed(with error: Error) {
		guard Thread.isMainThread else {
			return DispatchQueue.main.async { [weak self] in
				self?.didFinishLoadingFeed(with: error)
			}
		}

		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}
}
