//
//  FeedPresenterTests.swift
//  EssentialFeedTests
//
//  Created by Maksim Khozyashev on 10.07.2023.
//

import XCTest

final class FeedPresenter {
	init(view: Any) {
		
	}
}

final class FeedPresenterTests: XCTestCase {
	func test_init_doesNotSendMessagesToView() {
		let view = ViewSpy()

		_ = FeedPresenter(view: view)

		XCTAssertTrue(view.messages.isEmpty, "Expected no view messages")
	}
}

private final class ViewSpy {
	let messages = [Any]()
}
