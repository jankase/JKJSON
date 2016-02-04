//
// Created by Jan Kase on 05/01/16.
// Copyright (c) 2016 Jan Kase. All rights reserved.
//

import XCTest
@testable import JKJSON

class JSONDictionaryTest: XCTestCase {

  var jsonDictionary:      [String:JSONAcceptable]!
  var objectDictionary:    [String:JSONAcceptable]!
  var objcDictionary:      [String:AnyObject]!
  var primitiveDictionary: [String:NonJsonStruct]!

  override func setUp() {
    super.setUp()
    jsonDictionary = ["Mock": [JSONMock.StringKey: "TestJSON", JSONMock.IntKey: 10] as [String:JSONAcceptable], "BadMock": ["s": "TestJSON", JSONMock.IntKey: 10] as [String:JSONAcceptable]]
    objectDictionary = ["Mock": JSONMock(testString: "TestJSON", testInt: 10)] as [String:JSONAcceptable]
    objcDictionary = ["Mock": "TestString"] as [String:AnyObject]
    primitiveDictionary = ["TestInt": NonJsonStruct(internalInt: 1)]
  }

  func testJsonCreation() {
    let aJsonDictionary     = objectDictionary.json
    let aObjcJsonDictionary = objcDictionary.objcJson
    XCTAssertNotNil(aJsonDictionary, "Failed to create json dictionary")
    XCTAssertNotNil(aObjcJsonDictionary, "Failed to get objc json dicitonary")
  }

  func testAssignObjcObject() {
    var aNewDictionary = [:] as [String:JSONAcceptable]
    aNewDictionary.objcJson = objcDictionary
    XCTAssertEqual(aNewDictionary.count, 1, "Not inserted")
  }

  func testAssignNilJson() {
    jsonDictionary.objcJson = nil
    XCTAssertEqual(jsonDictionary.count, 0, "Dictionary not update")
  }
  
  func testObjcJsonFromPrimitiveArray() {
    let objcJson = primitiveDictionary.objcJson
    XCTAssertNil(objcJson, "Returned unexpected Dictionary")
  }

  func testGetObjectFromDictionary() {
    let mock: JSONMock? = jsonDictionary.objectForKey("Mock",
                                                      ofType: JSONMock.self,
                                                      defaultValue: JSONMock(testString: "", testInt: 0))
    XCTAssertNotNil(mock, "Returned nil from JSON dictionary")
    XCTAssertEqual(mock?.testInt, 10, "Unexpected value from JSON object")
    let mock2: JSONMock? = jsonDictionary.objectForKey("Test",
                                                       ofType: JSONMock.self,
                                                       defaultValue: JSONMock(testString: "", testInt: 0))
    XCTAssertNotNil(mock2, "Failed return default value")
    XCTAssertEqual(mock2?.testInt, 0, "Not default object returned")
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
