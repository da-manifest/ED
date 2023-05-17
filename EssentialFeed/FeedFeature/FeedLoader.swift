//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Maksim Khozyashev on 30.08.2021.
//

import Foundation

public protocol FeedLoader {
	typealias Result = Swift.Result<[FeedImage], Error>
    
    func load(completion: @escaping (Result) -> Void)
}
