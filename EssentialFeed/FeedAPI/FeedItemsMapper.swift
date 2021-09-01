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
        
        let items: [Item]
    }

    private struct Item: Decodable {
        
        let id: UUID
        let description: String?
        let location: String?
        let image: URL
     
        var item: FeedItem {
            FeedItem(id: id, description: description, location: location, imageURL: image)
        }
    }
    
    internal static func map(_ data: Data, _ response: HTTPURLResponse) throws -> [FeedItem] {
        guard response.statusCode == Constants.ok_200 else {
            throw RemoteFeedLoader.Error.invalidData
        }
        
        let root = try JSONDecoder().decode(Root.self, from: data)
        return root.items.map { $0.item }
    }
}
