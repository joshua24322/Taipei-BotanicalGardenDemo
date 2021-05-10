//
//  BotanicalDataListDemoTests.swift
//  BotanicalDataListDemoTests
//
//  Created by Joshua Chang on 2021/5/8.
//  Copyright © 2021 Joshua Chang. All rights reserved.
//

import XCTest
@testable import BotanicalDataListDemo

class BotanicalDataListDemoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.testUrlRequest()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testUrlRequest() {
        let mock = MockViewModel()
        mock.invokeDataList { (result) in
            XCTAssert(result)
        }
    }

}
