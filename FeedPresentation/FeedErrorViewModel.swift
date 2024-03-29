//
//  FeedErrorViewModel.swift
//  EssentialFeed
//
//  Created by Maksim Khozyashev on 10.07.2023.
//

import Foundation


public struct FeedErrorViewModel {
	public let message: String?

	static var noError: FeedErrorViewModel {
		return FeedErrorViewModel(message: nil)
	}

	static func error(message: String) -> FeedErrorViewModel {
		return FeedErrorViewModel(message: message)
	}
}
