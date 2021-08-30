//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Maksim Khozyashev on 30.08.2021.
//

import Foundation


enum LoadFeedResult {
    
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    
    func load(completion: @escaping (LoadFeedResult ) -> Void)
}
