//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Maksim Khozyashev on 24.11.2021.
//

import Foundation

internal struct RemoteFeedItem: Decodable {
    
    internal let id: UUID
    internal let description: String?
    internal let location: String?
    internal let image: URL
}
