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
		"My Feed"
	}

	private let feedView: FeedView
	private let loadingView: FeedLoadingView

	init(feedView: FeedView, loadingView: FeedLoadingView) {
		self.feedView = feedView
		self.loadingView = loadingView
	}

	func didStartLoadingFeed() {
		loadingView.display(FeedLoadingViewModel(isLoading: true))
	}

	func didFinishLoadingFeed(with feed: [FeedImage]) {
		feedView.display(FeedViewModel(feed: feed))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}

	func didFinishLoadingFeed(with error: Error) {
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}
}