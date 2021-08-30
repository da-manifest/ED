//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Maksim Khozyashev on 30.08.2021.
//

import XCTest

class RemoteFeedLoader {
    
    func load() {
        HTTPClient.shared.requestedURL = URL(string: "https://a-url.com")
    }
}

class HTTPClient {
    
    static let shared = HTTPClient()
    var requestedURL: URL?
    
    private init() {}
}

class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFRomURL() {
        let client = HTTPClient.shared
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        let client = HTTPClient.shared
        let sut = RemoteFeedLoader()
        
        sut.load()
        
        XCTAssertNotNil(client.requestedURL)
    }
}
