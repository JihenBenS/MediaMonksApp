import Foundation
import Combine
import XCTest

extension XCTestCase {
    func awaitPublisher<T: Publisher>(
        _ publisher: T,
        description: String = "Awaiting publisher",
        timeout: TimeInterval = 10,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T.Output {
        // We are using Swift's Result type to keep track of the result of our Combine pipeline:
        var result: Result<T.Output, Error>?
        let expectation = self.expectation(description: description)

        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = .failure(error)
                case .finished:
                    break
                }

                expectation.fulfill()
            },
            receiveValue: { value in
                result = .success(value)
            }
        )

        /* Here we await the expectation that we
        created at the top of our test, and once done, we
        also cancel our cancellable to avoid getting any
        unused variable warnings: */
        waitForExpectations(timeout: timeout)
        cancellable.cancel()

        /*Here we pass the original file and line number that
        our utility was called at, to tell XCTest to report
        any encountered errors at that original call site: */
        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )

        return try unwrappedResult.get()
    }
}
