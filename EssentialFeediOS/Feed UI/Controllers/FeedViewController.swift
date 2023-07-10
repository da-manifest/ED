//
//  FeedViewController.swift
//  EssentialFeediOS
//
//  Created by Maksim Khozyashev on 17.05.2023.
//

import UIKit

protocol FeedViewControllerDelegate {
	func didRequestFeedRefresh()
}

public final class FeedViewController: UITableViewController, UITableViewDataSourcePrefetching, FeedLoadingView {

	@IBAction private func refresh() {
		delegate?.didRequestFeedRefresh()
	}

	var delegate: FeedViewControllerDelegate?

	var tableModel = [FeedImageCellController]() {
		didSet {
			if Thread.isMainThread {
				tableView.reloadData()
			} else {
				DispatchQueue.main.async { [weak self] in
					self?.tableView.reloadData()
				}
			}
		}
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

	func display(_ viewModel: FeedLoadingViewModel) {
		guard Thread.isMainThread else {
			return DispatchQueue.main.async { [weak self] in
				self?.display(viewModel)
			}
		}
		if viewModel.isLoading {
			refreshControl?.beginRefreshing()
		} else {
			refreshControl?.endRefreshing()
		}
	}

	private func cellController(forRowAt indexPath: IndexPath) -> FeedImageCellController {
		tableModel[indexPath.row]
	}

	private func cancelCellControllerLoad(forRowAt indexPath: IndexPath) {
		cellController(forRowAt: indexPath).cancelLoad()
	}
}
