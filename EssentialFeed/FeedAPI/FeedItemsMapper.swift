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
        
        var feed: [FeedItem] {
            return items.map { $0.item }
        }
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
    
    internal static func map(_ data: Data, from response: HTTPURLResponse) -> RemoteFeedLoader.Result {
        guard response.statusCode == Constants.ok_200,
              let root = try? JSONDecoder().decode(Root.self, from: data)
        else {
            return .failure(.invalidData)
        }
        
        return .success(root.feed)
    }
}
