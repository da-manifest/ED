//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Maksim Khozyashev on 30.08.2021.
//

import Foundation

public enum LoadFeedResult {
    
    case success([FeedItem])
    case failure(Error)
}

protocol FeedLoader {
    
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
