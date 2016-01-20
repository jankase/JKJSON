//
//  Primitives.swift
//  JKJSON
//
//  Created by Jan Kase on 26/12/15.
//  Copyright © 2015 Jan Kase. All rights reserved.
//

import XCTest
@testable import JKJSON

private enum __ValueType: UInt {
  case Initial = 0, NewValue
}

private func __valueFor(type theType: __ValueType) -> [String:(Any, String)] {
  let aNumeric       = theType == .Initial ? 0 : 1
  let aNumericString = theType == .Initial ? "0" : "1"
  let aString        = theType == .Initial ? "JSON" : "New JSON"
  var aResult        = [:] as [String:(Any, String)]
  aResult["Int"] = (Int(aNumeric), aNumericString)
  aResult["Int64"] = (Int64(aNumeric), aNumericString)
  aResult["Int32"] = (Int32(aNumeric), aNumericString)
  aResult["Int16"] = (Int16(aNumeric), aNumericString)
  aResult["Int8"] = (Int8(aNumeric), aNumericString)
  aResult["UInt"] = (UInt(aNumeric), aNumericString)
  aResult["UInt64"] = (UInt64(aNumeric), aNumericString)
  aResult["UInt32"] = (UInt32(aNumeric), aNumericString)
  aResult["UInt16"] = (UInt16(aNumeric), aNumericString)
  aResult["UInt8"] = (UInt8(aNumeric), aNumericString)
  aResult["Bit"] = (theType == .Initial ? Bit.Zero : Bit.One, aNumericString)
  aResult["String"] = (aString, aString)
  aResult["Float"] = (Float(aNumeric), aNumericString)
  aResult["Double"] = (Double(aNumeric), aNumericString)
  return aResult
}

private let __json      = __valueFor(type: .Initial)
private let __newValues = __valueFor(type: .NewValue)

class PrimitiveTest: XCTestCase {

  override class func defaultTestSuite() -> XCTestSuite {
    let result = XCTestSuite(name: "Primitive test suite")
    result.addTest(PrimitiveTestHelper<String>.defaultTestSuite())
    result.addTest(PrimitiveTestHelper<Int>.defaultTestSuite())
    result.addTest(PrimitiveTestHelper<Int64>.defaultTestSuite())
    result.addTest(PrimitiveTestHelper<Int32>.defaultTestSuite())
    result.addTest(PrimitiveTestHelper<Int16>.defaultTestSuite())
    result.addTest(PrimitiveTestHelper<Int8>.defaultTestSuite())
    result.addTest(PrimitiveTestHelper<UInt>.defaultTestSuite())
    result.addTest(PrimitiveTestHelper<UInt64>.defaultTestSuite())
    result.addTest(PrimitiveTestHelper<UInt32>.defaultTestSuite())
    result.addTest(PrimitiveTestHelper<UInt16>.defaultTestSuite())
    result.addTest(PrimitiveTestHelper<UInt8>.defaultTestSuite())
    result.addTest(PrimitiveTestHelper<Bit>.defaultTestSuite())
    result.addTest(PrimitiveTestHelper<Float>.defaultTestSuite())
    result.addTest(PrimitiveTestHelper<Double>.defaultTestSuite())
    return result
  }

}

class PrimitiveTestHelper<T:protocol<JSONPrimitive, Equatable> where T.JSONRepresentationType == T>: XCTestCase {

  var testObject:           T?
  var testValue:            T.JSONRepresentationType?
  var newValue:             T.JSONRepresentationType?
  var stringRepresentation: String?

  override var name: String {
    return "\(T.self)"
  }

  override class func defaultTestSuite() -> XCTestSuite {
    let result = XCTestSuite(name: "JSONPrimitive:\(T.self)")
    result.addTest(PrimitiveTestHelper<T>.init(selector: "testCreation"))
    result.addTest(PrimitiveTestHelper<T>.init(selector: "testMultipleCreation"))
    result.addTest(PrimitiveTestHelper<T>.init(selector: "testEquality"))
    result.addTest(PrimitiveTestHelper<T>.init(selector: "testAssign"))
    result.addTest(PrimitiveTestHelper<T>.init(selector: "testStringCreation"))
    result.addTest(PrimitiveTestHelper<T>.init(selector: "testStringCreationFailure"))
    return result
  }

  override init(selector: Selector) {
    super.init(selector: selector)
  }

  override func setUp() {
    testObject = __json["\(T.self)"]?.0 as? T
    testValue = __json["\(T.self)"]?.0 as? T.JSONRepresentationType
    newValue = __newValues["\(T.self)"]?.0 as? T.JSONRepresentationType
    stringRepresentation = __json["\(T.self)"]?.1
  }

  func testCreation() {
    if let aTestValue = testValue {
      JSONCreateableTests<T>.testCreationFromJSONRepresentation(aTestValue)
    } else {
      XCTFail("Setup for \(T.self) failed")
    }
  }
  
  func testStringCreation() {
    if let aTestValue = stringRepresentation {
      JSONCreateableTests<T>.testCreationFromString("\(aTestValue)")
    } else {
      XCTFail("Setup for \(T.self) failed")
    }
  }

  func testStringCreationFailure() {
    if let _ = testObject as? String {
    } else {
      JSONCreateableTests<T>.testCreationFromString("abc", theFailExpected: true)
    }
  }

  func testMultipleCreation() {
    if let aTestValue = testValue, let aNewValue = newValue {
      JSONCreateableTests<T>.testCreationFromMultipleJSONRepresentation([aTestValue, aNewValue])
    } else {
      XCTFail("Setup for \(T.self) failed")
    }
  }

  func testEquality() {
    if let aTestObject = testObject {
      JSONCreateableTests<T>.testEqualityForJsonRepresentations(aTestObject)
    } else {
      XCTFail("Setup for \(T.self) failed")
    }
  }

  func testAssign() {
    if let aTestObject = testObject, let aNewValue = newValue {
      JSONMutableTests<T>.testAssignForJSONRepresentedObject(aTestObject, newValue: aNewValue)
    } else {
      XCTFail("Setup for \(T.self) failed")
    }
  }

}
