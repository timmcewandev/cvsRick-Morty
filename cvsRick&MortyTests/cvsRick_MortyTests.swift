//
//  cvsRick_MortyTests.swift
//  cvsRick&MortyTests
//
//  Created by Tim McEwan on 3/28/25.
//

import XCTest
@testable import cvsRick_Morty

final class cvsRick_MortyTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDebounceIfUserStopsTyping() async throws {
        Task {
           /// User opens up a task on starts typing on keyboard. In order not to run up the request on each keystroke. We debounce setup a wait time hopefully the user is done///
        }
        let debounceInterval: Double = 0.2
        
        // Debounce the API call
        try await Task.sleep(nanoseconds: UInt64(debounceInterval * 1_000_000_000))
        
        // Check if the task was cancelled during the sleep
        if Task.isCancelled {
            XCTFail("Means the user cancelled typing")
        }
    }

}
