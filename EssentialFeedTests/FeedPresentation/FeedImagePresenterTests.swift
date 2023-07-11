//
//  FeedImagePresenterTests.swift
//  EssentialFeedTests
//
//  Created by Maksim Khozyashev on 11.07.2023.
//

import XCTest
import EssentialFeed


struct FeedImageViewModel<Image> {
	let description: String?
	let location: String?
	let image: Image?
	let isLoading: Bool
	let shouldRetry: Bool

	var hasLocation: Bool {
		return location != nil
	}
}

protocol FeedImageView {
	associatedtype Image

	func display(_ model: FeedImageViewModel<Image>)
}

final class FeedImagePresenter<View: FeedImageView, Image> where View.Image == Image {
	private let view: View
	private let imageTransformer: (Data) -> Image?

	internal init(view: View, imageTransformer: @escaping (Data) -> Image?) {
		self.view = view
		self.imageTransformer = imageTransformer
	}

	func didStartLoadingImageData(for model: FeedImage) {
		view.display(FeedImageViewModel(
			description: model.description,
			location: model.location,
			image: nil,
			isLoading: true,
			shouldRetry: false))
	}

	private struct InvalidImageDataError: Error {}

	func didFinishLoadingImageData(with data: Data, for model: FeedImage) {
		let image = imageTransformer(data)
		view.display(FeedImageViewModel(
			description: model.description,
			location: model.location,
			image: image,
			isLoading: false,
			shouldRetry: image == nil))
	}

	func didFinishLoadingImageData(with error: Error, for model: FeedImage) {
		view.display(FeedImageViewModel(
			description: model.description,
			location: model.location,
			image: nil,
			isLoading: false,
			shouldRetry: true))
	}
}

final class FeedImagePresenterTests: XCTestCase {
	func test_init_doesNotSendMessagesToView() {
		let (_, view) = makeSUT()

		XCTAssertTrue(view.messages.isEmpty, "Expected no view messages")
	}

	func test_didStartLoadingImageData_displaysLoadingImage() {
		let (sut, view) = makeSUT()
		let image = uniqueImage()

		sut.didStartLoadingImageData(for: image)

		let message = view.messages.first
		XCTAssertEqual(view.messages.count, 1)
		XCTAssertEqual(message?.description, image.description)
		XCTAssertEqual(message?.location, image.location)
		XCTAssertEqual(message?.isLoading, true)
		XCTAssertEqual(message?.shouldRetry, false)
		XCTAssertNil(message?.image)
	}

	func test_didFinishLoadingImageData_displaysRetryOnImageTransformationFail() {
		let (sut, view) = makeSUT(imageTransformer: fail)
		let image = uniqueImage()
		let data = Data()

		sut.didFinishLoadingImageData(with: data, for: image)

		let message = view.messages.first
		XCTAssertEqual(view.messages.count, 1)
		XCTAssertEqual(message?.description, image.description)
		XCTAssertEqual(message?.location, image.location)
		XCTAssertEqual(message?.isLoading, false)
		XCTAssertEqual(message?.shouldRetry, true)
		XCTAssertNil(message?.image)
	}

	func test_didFinishLoadingImageData_displaysImageOnSuccessfulImageTransformation() {
		let image = uniqueImage()
		let data = Data()
		let transformedData = AnyImage()
		let (sut, view) = makeSUT(imageTransformer: { _ in transformedData })

		sut.didFinishLoadingImageData(with: data, for: image)

		let message = view.messages.first
		XCTAssertEqual(view.messages.count, 1)
		XCTAssertEqual(message?.description, image.description)
		XCTAssertEqual(message?.location, image.location)
		XCTAssertEqual(message?.isLoading, false)
		XCTAssertEqual(message?.shouldRetry, false)
		XCTAssertEqual(message?.image, transformedData)
	}

	func test_didFinishLoadingImageDataWithError_displaysRetry() {
		let image = uniqueImage()
		let (sut, view) = makeSUT()

		sut.didFinishLoadingImageData(with: anyNSError(), for: image)

		let message = view.messages.first
		XCTAssertEqual(view.messages.count, 1)
		XCTAssertEqual(message?.description, image.description)
		XCTAssertEqual(message?.location, image.location)
		XCTAssertEqual(message?.isLoading, false)
		XCTAssertEqual(message?.shouldRetry, true)
		XCTAssertNil(message?.image)
	}

	private var fail: (Data) -> AnyImage? {
		return { _ in nil }
	}

	private struct AnyImage: Equatable {}

	private final class ViewSpy: FeedImageView {
		private(set) var messages = [FeedImageViewModel<AnyImage>]()

		func display(_ model: FeedImageViewModel<AnyImage>) {
			messages.append(model)
		}
	}
}

//MARK: - Helpers
private extension FeedImagePresenterTests {
	private func makeSUT(
		imageTransformer: @escaping (Data) -> AnyImage? = { _ in nil },
		file: StaticString = #filePath,
		line: UInt = #line
	) -> (sut: FeedImagePresenter<ViewSpy, AnyImage>, view: ViewSpy) {
		let view = ViewSpy()
		let sut = FeedImagePresenter(view: view, imageTransformer: imageTransformer)
		trackForMemoryLeaks(view,file: file, line: line)
		trackForMemoryLeaks(sut, file: file, line: line)
		return (sut, view)
	}
}

extension UIImage {
	static func makeImage(withColor color: UIColor) -> UIImage {
		let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
		UIGraphicsBeginImageContext(rect.size)
		let context = UIGraphicsGetCurrentContext()
		context?.setFillColor(color.cgColor)
		context?.fill(rect)
		let img = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return img!
	}
	}
