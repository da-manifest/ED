//
//  CoreDataFeedStore.swift
//  EssentialFeed
//
//  Created by Maksim Khozyashev on 16.05.2023.
//

import CoreData

public final class CoreDataFeedStore {
	private let container: NSPersistentContainer
	private let context: NSManagedObjectContext

	public init(storeURL: URL, bundle: Bundle = .main) throws {
		container = try NSPersistentContainer.load(modelName: "FeedStore", url: storeURL, in: bundle)
		context = container.newBackgroundContext()
	}

	func perform(_ action: @escaping (NSManagedObjectContext) -> Void) {
		let context = context
		context.perform { action(context) }
	}
}
