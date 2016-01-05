//
// Created by Jan Kase on 05/01/16.
// Copyright (c) 2016 Jan Kase. All rights reserved.
//

import XCTest
@testable import JKJSON

class OptionalDictionaryTests: XCTestCase {

  var testOptionalDictionary: [String:Any]?
  var testDictionary:         [String:Any]!

  override func setUp() {
    super.setUp()
    testOptionalDictionary = nil
    testDictionary = ["Test": 1]
  }

  func testSetOptionalDictionaryWithOptionalValue() {
    testOptionalDictionary.setOptionalObject(nil, forKey: "Test")
    XCTAssertNil(testOptionalDictionary)
    testOptionalDictionary.setOptionalObject(1, forKey: "Test")
    XCTAssertNotNil(testOptionalDictionary)
    XCTAssertEqual(testOptionalDictionary?.count, 1)
    testOptionalDictionary.setOptionalObject(nil, forKey: "Test")
    XCTAssertEqual(testOptionalDictionary?["Test"] as? Int, 1)
  }

  func testSetDictionaryWithOptionalValue() {
    testDictionary.setOptionalObject(nil, forKey: "Test")
    XCTAssertEqual(testDictionary["Test"] as? Int, 1)
    testDictionary.setOptionalObject(0, forKey: "Test")
    XCTAssertEqual(testDictionary["Test"] as? Int, 0)
  }

}
