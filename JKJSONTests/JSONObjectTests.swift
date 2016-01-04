//
// Created by Jan Kase on 04/01/16.
// Copyright (c) 2016 Jan Kase. All rights reserved.
//

import XCTest
@testable import JKJSON

class JSONObjectTests: XCTestCase {

  var testObject:  JSONMock!
  var testJSON:    [String:JSONAcceptable]!
  var testBadJSON: [String:JSONAcceptable]!

  override func setUp() {
    super.setUp()
    testObject = JSONMock(testString: "Test JSON", testInt: 0)
    testJSON = [JSONMock.StringKey: "Test JSON", JSONMock.IntKey: 0]
    testBadJSON = ["s": "Test JSON", JSONMock.IntKey: 0]
  }

  func testCreation() {
    let aTestObject = JSONMock(jsonRepresentation: testJSON)
    XCTAssertNotNil(aTestObject, "Failed to create JSON object")
    XCTAssertEqual(testObject, aTestObject, "Created object not equal correct version")
  }

  func testCreationWithBadInput() {
    let aTestObject = JSONMock(jsonRepresentation: testBadJSON)
    XCTAssertNil(aTestObject, "Object created from bad JSON")
  }

  func testMulipleJsonCreationWithBadInput() {
    let aTestJsonArray   = [testBadJSON!]
    let aTestObjectArray = JSONMock.instancesFromJSON(aTestJsonArray)
    XCTAssertNil(aTestObjectArray, "Created array even only bad input")
  }

}
