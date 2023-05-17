//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Maksim Khozyashev on 24.11.2021.
//

import Foundation

 struct RemoteFeedItem: Decodable {
    
     let id: UUID
     let description: String?
     let location: String?
     let image: URL
}
