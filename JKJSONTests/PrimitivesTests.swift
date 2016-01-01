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

private func __valueFor(type theType: __ValueType) -> [String:Any] {
  let numeric = theType == .Initial ? 0 : 1
  let string  = theType == .Initial ? "JSON" : "New JSON"
  var result  = [:] as [String:Any]
  result["Int"] = Int(numeric)
  result["Int64"] = Int64(numeric)
  result["Int32"] = Int32(numeric)
  result["Int16"] = Int16(numeric)
  result["Int8"] = Int8(numeric)
  result["UInt"] = UInt(numeric)
  result["UInt64"] = UInt64(numeric)
  result["UInt32"] = UInt32(numeric)
  result["UInt16"] = UInt16(numeric)
  result["UInt8"] = UInt8(numeric)
  result["Bit"] = theType == .Initial ? Bit.Zero : Bit.One
  result["String"] = string
  result["Float"] = Float(numeric)
  result["Double"] = Double(numeric)
  return result
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

  var testObject: T?
  var testValue:  T.JSONRepresentationType?
  var newValue:   T.JSONRepresentationType?

  override var name: String {
    return "\(T.self)"
  }

  override class func defaultTestSuite() -> XCTestSuite {
    let result = XCTestSuite(name: "JSONPrimitive:\(T.self)")
    result.addTest(PrimitiveTestHelper<T>.init(selector: "testCreation"))
    result.addTest(PrimitiveTestHelper<T>.init(selector: "testMultipleCreation"))
    result.addTest(PrimitiveTestHelper<T>.init(selector: "testEquality"))
    result.addTest(PrimitiveTestHelper<T>.init(selector: "testAssign"))
    return result
  }

  override init(selector: Selector) {
    super.init(selector: selector)
  }

  override func setUp() {
    testObject = __json["\(T.self)"] as? T
    testValue = __json["\(T.self)"] as? T.JSONRepresentationType
    newValue = __newValues["\(T.self)"] as? T.JSONRepresentationType
  }

  func testCreation() {
    if let aTestValue = testValue {
      JSONCreateableTests<T>.testCreationFromJSONRepresentation(aTestValue)
    } else {
      XCTFail("Setup for \(T.self) failed")
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
