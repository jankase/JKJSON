//
// Created by Jan Kase on 04/01/16.
// Copyright (c) 2016 Jan Kase. All rights reserved.
//

import XCTest
@testable import JKJSON

class JSONArrayTests: XCTestCase {

  var jsonArray:   [JSONAcceptable]!
  var objectArray: [JSONAcceptable]!

  override func setUp() {
    super.setUp()
    jsonArray = ["Test", 0, [JSONMock.StringKey: "TestJSON", JSONMock.IntKey: 10] as [String:JSONAcceptable], ["s": "TestJSON", JSONMock.IntKey: 0] as [String:JSONAcceptable]]
    objectArray = ["Test", 0, JSONMock(testString: "TestJSON", testInt: 10)] as [JSONAcceptable]
  }

  func testCreation() {
    let aJSONArray = objectArray.json
    XCTAssertNotNil(aJSONArray, "JSON array not created")
    XCTAssertEqual(aJSONArray.count, objectArray.count, "Not all elements trafered to JSON")
  }

  func testOptionalPrimitiveFromArray() {
    XCTAssertEqual("Test", jsonArray.optionalObjectAtIndex(0, withType: String.self, defaultValue: nil), "Fail retrieve string")
    XCTAssertEqual(0, jsonArray.optionalObjectAtIndex(1, withType: Int.self), "Fail retrieve int")
    XCTAssertNil(jsonArray.optionalObjectAtIndex(0, withType: Int.self), "Retrieved int even source is string")
    XCTAssertNil(jsonArray.optionalObjectAtIndex(1, withType: String.self), "Retrieved String even when source is Int")
  }

  func testPrimitiveFromArray() {
    XCTAssertEqual(0, jsonArray.objectAtIndex(1, withType: Int.self, defaultValue: 1), "Failed retrieve int")
    XCTAssertEqual(1, jsonArray.objectAtIndex(0, withType: Int.self, defaultValue: 1), "Value retrieved even not matching type")
  }
  
  func testObjectFromArray() {
    XCTAssertEqual(jsonArray.optionalObjectAtIndex(2, withType: JSONMock.self)?.testInt, 10, "Retrieved object not identical test int value")
    XCTAssertEqual(jsonArray.optionalObjectAtIndex(2, withType: JSONMock.self)?.testString, "TestJSON", "Retrieved object not identical test string value")
  }

  func testUpdateObjectFromArray() {
    let obj  = JSONMock(testString: "Test", testInt: 0)
    let obj2 = jsonArray.updateObjectValue(obj, fromIndex: 2)
    XCTAssertEqual(obj2.testString, "TestJSON", "Created test string failed from JSON")
    XCTAssertEqual(obj2.testInt, 10, "Created test int failed from JSON")
  }

  func testUpdateObjectFromArrayWithBadInput() {
    let obj  = JSONMock(testString: "Test", testInt: 0)
    let obj2 = jsonArray.updateObjectValue(obj, fromIndex: 3)
    XCTAssertEqual(obj2.testString, "Test", "Created test string failed from JSON")
    XCTAssertEqual(obj2.testInt, 0, "Created test int failed from JSON")
  }

}
