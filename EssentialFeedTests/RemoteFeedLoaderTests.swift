//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Maksim Khozyashev on 30.08.2021.
//

import XCTest

class RemoteFeedLoader {
    
}

class HTTPClient {
    
    var requestedURL: URL?
}

class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFRomURL() {
        let client = HTTPClient()
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requestedURL)
    }
}
