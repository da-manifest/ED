//
//  FeedImageDataStore.swift
//  EssentialFeed
//
//  Created by Maksim Khozyashev on 11.07.2023.
//

import Foundation


public protocol FeedImageDataStore {
	typealias Result = Swift.Result<Data?, Error>

	func retrieve(dataForURL url: URL, completion: @escaping (Result) -> Void)
}
