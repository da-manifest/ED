//
//  FeedImageCell+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Maksim Khozyashev on 19.05.2023.
//

import UIKit
import EssentialFeediOS

extension FeedImageCell {
	var isShowingLocation: Bool {
		!locationContainer.isHidden
	}

	var isShowingImageLoadingIndicator: Bool {
		feedImageContainer.isShimmering
	}

	var isShowingRetryAction: Bool {
		!feedImageRetryButton.isHidden
	}

	var locationText: String? {
		locationLabel.text
	}

	var descriptionText: String? {
		descriptionLabel.text
	}

	var renderedImage: Data? {
		feedImageView.image?.pngData()
	}

	func simulateRetryAction() {
		feedImageRetryButton.simulateTap()
	}
}
