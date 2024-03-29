//
//  FeedCacheTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Maksim Khozyashev on 25.11.2021.
//

import Foundation
import EssentialFeed

func uniqueImage() -> FeedImage {
    return FeedImage(id: UUID(),
                     description: "any",
                     location: "any",
                     url: anyURL())
}

func uniqueImageFeed() -> (models: [FeedImage], local: [LocalFeedImage]) {
    let models = [uniqueImage(), uniqueImage()]
    let localItems = models.map { LocalFeedImage(id: $0.id,
                                                 description: $0.description,
                                                 location: $0.location,
                                                 url: $0.url)
    }
    return (models, localItems)
}

extension Date {
    
    private enum Constants {
        
        static let feedCacheMaxAgeInDays = 7
    }
    
    func minusFeedCacheMaxAge() -> Date {
        return adding(days: -Constants.feedCacheMaxAgeInDays)
    }
    
    private func adding(days: Int) -> Date {
        return Calendar(identifier: .gregorian).date(byAdding: .day, value: days, to: self)!
    }
}

extension Date {
    
    func adding(seconds: Int) -> Date {
        return Calendar(identifier: .gregorian).date(byAdding: .second, value: seconds, to: self)!
    }
}
