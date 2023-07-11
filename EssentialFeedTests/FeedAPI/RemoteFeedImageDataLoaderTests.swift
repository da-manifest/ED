//
//  RemoteFeedImageDataLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Maksim Khozyashev on 11.07.2023.
//

import XCTest


final class RemoteFeedImageDataLoader {

}

class RemoteFeedImageDataLoaderTests: XCTestCase {

	func test_init_doesNotPerformAnyULRRequests() {
		let (_, client) = makeSUT()

		XCTAssertTrue(client.requestedURLs.isEmpty)
	}

	//MARK: - Helpers
	private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: RemoteFeedImageDataLoader, client: HTTPClientSpy) {
		let sut = RemoteFeedImageDataLoader()
		let client = HTTPClientSpy()

		trackForMemoryLeaks(sut, file: file, line: line)
		trackForMemoryLeaks(client, file: file, line: line)

		return (sut, client)
	}

	private final class HTTPClientSpy {
		let requestedURLs = [URL]()
	}
}
