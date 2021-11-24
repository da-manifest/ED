//
//  FeedItemsMapper.swift
//  EssentialFeed
//
//  Created by Maksim Khozyashev on 01.09.2021.
//

import Foundation

private enum Constants {
    
    static let ok_200 = 200
}

internal final class FeedItemsMapper {
    
    private struct Root: Decodable {
        
        let items: [RemoteFeedItem]
    }
    
    internal static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteFeedItem] {
        guard response.statusCode == Constants.ok_200,
              let root = try? JSONDecoder().decode(Root.self, from: data)
        else {
            throw RemoteFeedLoader.Error.invalidData
        }
        
        return root.items
    }
}
