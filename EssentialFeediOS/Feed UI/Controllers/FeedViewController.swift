//
//  FeedViewController.swift
//  EssentialFeediOS
//
//  Created by Maksim Khozyashev on 17.05.2023.
//

import UIKit
import EssentialFeed

protocol FeedViewControllerDelegate {
	func didRequestFeedRefresh()
}

public final class FeedViewController: UITableViewController, UITableViewDataSourcePrefetching, FeedLoadingView, FeedErrorView {

	@IBOutlet private(set) public var errorView: ErrorView?

	@IBAction private func refresh() {
		delegate?.didRequestFeedRefresh()
	}

	var delegate: FeedViewControllerDelegate?
	
	var tableModel = [FeedImageCellController]() {
		didSet { tableView.reloadData() }
	}

	public override func viewDidLoad() {
		super.viewDidLoad()

		refresh()
	}
	
	override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		tableModel.count
	}

	public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return cellController(forRowAt: indexPath).view(in: tableView)
	}

	public override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		cancelCellControllerLoad(forRowAt: indexPath)
	}

	public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
		indexPaths.forEach { indexPath in
			cellController(forRowAt: indexPath).preload()
		}
	}

	public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
		indexPaths.forEach(cancelCellControllerLoad)
	}

	public func display(_ viewModel: FeedLoadingViewModel) {
		refreshControl?.update(isRefreshing: viewModel.isLoading)
	}

	public func display(_ viewModel: FeedErrorViewModel) {
		errorView?.message = viewModel.message
	}

	private func cellController(forRowAt indexPath: IndexPath) -> FeedImageCellController {
		tableModel[indexPath.row]
	}

	private func cancelCellControllerLoad(forRowAt indexPath: IndexPath) {
		cellController(forRowAt: indexPath).cancelLoad()
	}
}
