//
//  FeedImagePresenterTests.swift
//  EssentialFeedTests
//
//  Created by Maksim Khozyashev on 11.07.2023.
//

import XCTest


final class FeedImagePresenter {}

final class FeedImagePresenterTests: XCTestCase {
	func test_init_doesNotSendMessagesToView() {
		let (_, view) = makeSUT()

		XCTAssertTrue(view.messages.isEmpty, "Expected no view messages")
	}

	private final class ViewSpy {
		let messages = [Any]()
	}
}

//MARK: - Helpers
private extension FeedImagePresenterTests {
	private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: FeedImagePresenter, view: ViewSpy) {
		let view = ViewSpy()
		let sut = FeedImagePresenter()
		trackForMemoryLeaks(view,file: file, line: line)
		trackForMemoryLeaks(sut, file: file, line: line)
		return (sut, view)
	}
}
