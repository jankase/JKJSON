//
// Created by Jan Kase on 05/01/16.
// Copyright (c) 2016 Jan Kase. All rights reserved.
//

import XCTest
@testable import JKJSON

class OptionalArrayTest: XCTestCase {

  var testOptionalArray: [Any]?
  var testArray:         [Any]!

  override func setUp() {
    super.setUp()
    testOptionalArray = nil
    testArray = [0]
  }

  func testAddOptionalToOptionalArray() {
    testOptionalArray.append(nil)
    XCTAssertNil(testOptionalArray)
  }

  func testAddToOptionalArray() {
    testOptionalArray.append(1)
    XCTAssertNotNil(testOptionalArray)
    XCTAssertEqual(testOptionalArray?.count, 1)
  }

  func testSetObjectToOptionalArray() {
    do {
      try testOptionalArray.setOptionalObject(1, index: 0)
    } catch {
      XCTFail("Crashed during adding element on first position to optional array")
    }
    XCTAssertNotNil(testOptionalArray)
    XCTAssertEqual(testOptionalArray?.count, 1)
    XCTAssertEqual(testOptionalArray?[0] as? Int, 1)
  }

  func testAddOptionlToArray() {
    testArray.appendOptional(nil)
    XCTAssertEqual(testArray.count, 1)
  }

  func testSetOptionalToArray() {
    do {
      try testArray.setOptionalObject(nil, index: 0)
    } catch {
      XCTFail("Fail insert object to array on given index")
    }
    XCTAssertEqual(testArray.count, 1)
    XCTAssertEqual(testArray[0] as? Int, 0)
  }

  func testSetObjectToArray() {
    let aTestValue: Int? = 1
    do {
      try testArray.setOptionalObject(aTestValue, index: 0)
    } catch {
      XCTFail("Fail insert object to array on given index")
    }
    XCTAssertEqual(testArray.count, 1)
    XCTAssertEqual(testArray[0] as? Int, 1)
  }

  func testSetObjectToArrayOutOfBounds() {
    do {
      try testOptionalArray.setOptionalObject(1, index: 1)
      XCTFail("Insertion should fail on out of bounds - optional array")
    } catch {
    }
    testOptionalArray = []
    do {
      try testOptionalArray.setOptionalObject(1, index: 1)
      XCTFail("Insertion should fail on out of bounds - existing array")
    } catch {
    }
  }

  func testAppendOptionalToArray() {
    let aTestValue: Int? = 1
    testArray.appendOptional(aTestValue)
    XCTAssertEqual(testArray.count, 2)
    XCTAssertEqual(testArray.last as? Int, 1)
    XCTAssertEqual(testArray[0] as? Int, 0)
  }

}