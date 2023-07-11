//
//  FeedItemsMapper.swift
//  EssentialFeed
//
//  Created by Maksim Khozyashev on 01.09.2021.
//

import Foundation

 final class FeedItemsMapper {
    
    private struct Root: Decodable {
        let items: [RemoteFeedItem]
    }
    
     static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteFeedItem] {
		 guard response.isOK, let root = try? JSONDecoder().decode(Root.self, from: data) else {
			 throw RemoteFeedLoader.Error.invalidData
		 }
        
        return root.items
    }
}
