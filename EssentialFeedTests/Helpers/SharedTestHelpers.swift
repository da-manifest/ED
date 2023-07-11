//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Maksim Khozyashev on 25.11.2021.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    return URL(string: "http://a-url.com")!
}

func anyData() -> Data {
	return Data("any data".utf8)
}
