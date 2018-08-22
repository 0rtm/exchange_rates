//
//  RouteTest.swift
//  exchangeRatesTests
//
//  Created by Artem Tselikov on 2018-08-22.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import XCTest
@testable import exchangeRates

class RouteTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

    func testCorrectRequestParams() {

        let route = Route.rates(base: "EUR")

        let url = URL(string: "latest?base=EUR")!

    }

    
}
