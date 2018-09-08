//
//  MyTestTests.swift
//  MyTestTests
//
//  Created by Yujiro Takeyama on 2018/06/30.
//  Copyright © 2018年 Yujiro Takeyama. All rights reserved.
//

import XCTest
import RxSwift
import Mockingjay
@testable import MyTest

class MyTestTests: XCTestCase {

    private let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let data: [String: String] = [
            "result" : "OKOK"
        ]
        stub(http(.get, uri: "/articles"), json(data))
        
        let infraSampleForTest = InfraSampleForTest()
        let observable = infraSampleForTest.getArticles()
        var result: Int = 0
        let expectation = self.expectation(description: #function)
        observable
            .subscribeOn(ConcurrentMainScheduler.instance)
            .subscribe(onCompleted: {
                result = 2
                expectation.fulfill()
            })
            .disposed(by: self.disposeBag)
        waitForExpectations(timeout: 1.0) { error in
            XCTAssertEqual(result, 3)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
