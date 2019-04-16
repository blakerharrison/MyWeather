//
//  ConversionTests.swift
//  MyWeatherTests
//
//  Created by Blake Harrison on 4/15/19.
//  Copyright © 2019 Blake Harrison. All rights reserved.
//

import XCTest

class ConversionTests: XCTestCase {

    func test0DegreesEqualsNorth() {
        let degrees = 0
        XCTAssertEqual(degrees.degreesToWindDirection, "N")
    }
    
    func test360DegreesEqualsNorth() {
        let degrees = 360
        XCTAssertEqual(degrees.degreesToWindDirection, "N")
    }

    func test1Through44DegreesEqualsNNE() {
        let degrees = Int.random(in: 1 ... 44)
        XCTAssertEqual(degrees.degreesToWindDirection, "NNE")
    }
    
    func test45DegreesEqualsNE() {
        let degrees = 45
        XCTAssertEqual(degrees.degreesToWindDirection, "NE")
    }

    func test46Through89DegreesEqualsENE() {
        let degrees = Int.random(in: 46 ... 89)
        XCTAssertEqual(degrees.degreesToWindDirection, "ENE")
    }
    
    func test90DegreesEqualsN() {
        let degrees = 90
        XCTAssertEqual(degrees.degreesToWindDirection, "E")
    }
    
    func test91Through134DegreesEqualsESE() {
        let degrees = Int.random(in: 91 ... 134)
        XCTAssertEqual(degrees.degreesToWindDirection, "ESE")
    }
    
    func test135DegreesEqualsSE() {
        let degrees = 135
        XCTAssertEqual(degrees.degreesToWindDirection, "SE")
    }
    
    func test136Through179DegreesEqualsSSE() {
        let degrees = Int.random(in: 136 ... 179)
        XCTAssertEqual(degrees.degreesToWindDirection, "SSE")
    }
    
    func test180DegreesEqualsS() {
        let degrees = 180
        XCTAssertEqual(degrees.degreesToWindDirection, "S")
    }
    
    func test181Through224DegreesEqualsSSW() {
        let degrees = Int.random(in: 181 ... 224)
        XCTAssertEqual(degrees.degreesToWindDirection, "SSW")
    }
    
    func test225DegreesEqualsSW() {
        let degrees = 225
        XCTAssertEqual(degrees.degreesToWindDirection, "SW")
    }
    
    func test226Through269DegreesEqualsWSW() {
        let degrees = Int.random(in: 226 ... 269)
        XCTAssertEqual(degrees.degreesToWindDirection, "WSW")
    }
    
    func test270DegreesEqualsW() {
        let degrees = 270
        XCTAssertEqual(degrees.degreesToWindDirection, "W")
    }
    
    func test271Through314DegreesEqualsWNW() {
        let degrees = Int.random(in: 271 ... 314)
        XCTAssertEqual(degrees.degreesToWindDirection, "WNW")
    }
    
    func test315DegreesEqualsNW() {
        let degrees = 315
        XCTAssertEqual(degrees.degreesToWindDirection, "NW")
    }
    
    func test316Through314DegreesEquals359() {
        let degrees = Int.random(in: 316 ... 359)
        XCTAssertEqual(degrees.degreesToWindDirection, "NNW")
    }
    
}
