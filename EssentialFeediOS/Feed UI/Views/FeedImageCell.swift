//
//  FeedImageCell.swift
//  EssentialFeediOS
//
//  Created by Maksim Khozyashev on 18.05.2023.
//

import UIKit

public final class FeedImageCell: UITableViewCell {
	@IBOutlet private(set) public var locationContainer: UIView!
	@IBOutlet private(set) public var locationLabel: UILabel!
	@IBOutlet private(set) public var descriptionLabel: UILabel!
	@IBOutlet private(set) public var feedImageContainer: UIView!
	@IBOutlet private(set) public var feedImageView: UIImageView!

	@IBAction private func retryButtonTapped() {
		onRetry?()
	}

	private(set) public lazy var feedImageRetryButton: UIButton = {
		let button = UIButton()
		button.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
		return button
	}()

	var onRetry: (() -> Void)?
}
