//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Maksim Khozyashev on 30.08.2021.
//

import Foundation

public struct FeedItem: Equatable {
    
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
