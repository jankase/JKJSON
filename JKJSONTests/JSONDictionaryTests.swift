//
// Created by Jan Kase on 05/01/16.
// Copyright (c) 2016 Jan Kase. All rights reserved.
//

import XCTest
@testable import JKJSON

class JSONDictionaryTest: XCTestCase {

  var jsonDictionary:   [String:JSONAcceptable]!
  var objectDictionary: [String:JSONAcceptable]!

  override func setUp() {
    super.setUp()
    jsonDictionary = ["Mock": [JSONMock.StringKey: "TestJSON", JSONMock.IntKey: 10] as [String:JSONAcceptable], "BadMock": ["s": "TestJSON", JSONMock.IntKey: 10] as [String:JSONAcceptable]]
    objectDictionary = ["Mock": JSONMock(testString: "TestJSON", testInt: 10)] as [String:JSONAcceptable]
  }

  func testJsonCreation() {
    let aJsonDictionary = objectDictionary.json
    XCTAssertNotNil(aJsonDictionary, "Failed to create json dictionary")
  }

  func testJsonObjectEquality() {
    let aJsonDictionary = objectDictionary.json
    XCTAssertEqual(aJsonDictionary.optionalObjectForKey("Mock", ofType: JSONMock.self)?.testString, "TestJSON")
    XCTAssertEqual(aJsonDictionary.optionalObjectForKey("Mock", ofType: JSONMock.self)?.testInt, 10)
  }

  func testJsonUpdateObject() {
    let aMock  = JSONMock(testString: "Test", testInt: 0)
    let aMock2 = jsonDictionary.updateObject(aMock, fromKey: "Mock")
    XCTAssertEqual(aMock2.testInt, 10)
    XCTAssertEqual(aMock2.testString, "TestJSON")
  }

}
