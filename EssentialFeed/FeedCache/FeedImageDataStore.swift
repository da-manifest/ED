//
//  FeedImageDataStore.swift
//  EssentialFeed
//
//  Created by Maksim Khozyashev on 11.07.2023.
//

import Foundation


public protocol FeedImageDataStore {
	typealias RetrievalResult = Swift.Result<Data?, Error>
	typealias InsertionResult = Swift.Result<Void, Error>

	func retrieve(dataForURL url: URL, completion: @escaping (RetrievalResult) -> Void)
	func insert(_ data: Data, for url: URL, completion: @escaping (InsertionResult) -> Void)
}
