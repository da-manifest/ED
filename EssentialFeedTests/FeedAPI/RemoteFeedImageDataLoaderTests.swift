//
//  RemoteFeedImageDataLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Maksim Khozyashev on 11.07.2023.
//

import XCTest
import EssentialFeed


final class RemoteFeedImageDataLoader {
	private let client: HTTPClient

	init(client: HTTPClient) {
		self.client = client
	}

	func loadImageData(from url: URL, completion: @escaping (Any) -> Void) {
		client.get(from: url) { _ in }
	}
}

class RemoteFeedImageDataLoaderTests: XCTestCase {

	func test_init_doesNotPerformAnyULRRequests() {
		let (_, client) = makeSUT()

		XCTAssertTrue(client.requestedURLs.isEmpty)
	}

	func test_loadImageDataFromURL_requestsDataFromURL() {
		let (sut, client) = makeSUT()
		let url = anyURL()

		sut.loadImageData(from: url) { _ in }

		XCTAssertEqual(client.requestedURLs, [url])
	}

	func test_loadImageDataFromURLTwice_requestsDataFromURLTwice() {
		let (sut, client) = makeSUT()
		let url = anyURL()

		sut.loadImageData(from: url) { _ in }
		sut.loadImageData(from: url) { _ in }

		XCTAssertEqual(client.requestedURLs, [url, url])
	}

	//MARK: - Helpers
	private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: RemoteFeedImageDataLoader, client: HTTPClientSpy) {
		let client = HTTPClientSpy()
		let sut = RemoteFeedImageDataLoader(client: client)

		trackForMemoryLeaks(sut, file: file, line: line)
		trackForMemoryLeaks(client, file: file, line: line)

		return (sut, client)
	}

	private final class HTTPClientSpy: HTTPClient {
		private(set) var requestedURLs = [URL]()

		func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) {
			requestedURLs.append(url)
		}
	}
}
