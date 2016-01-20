//
// Created by Jan Kase on 27/12/15.
// Copyright (c) 2015 Jan Kase. All rights reserved.
//

import Foundation

import XCTest
@testable import JKJSON

struct JSONCreateableTests<T:JSONStaticCreatable> {

  static func testCreationFromJSONRepresentation(theJsonRepresentation: T.JSONRepresentationType) {
    let aMappedObject = T.instanceFromJSON(theJsonRepresentation)
    XCTAssertNotNil(aMappedObject, "Mapped object not created")
  }

  static func testCreationFromMultipleJSONRepresentation(theJsonRepresentations: [T.JSONRepresentationType]) {
    let aMappedObjects = T.instancesFromJSON(theJsonRepresentations)
    XCTAssertNotNil(aMappedObjects, "Mapped objects not created")
    XCTAssertEqual(aMappedObjects?.count, theJsonRepresentations.count, "Number of created objects does not fit provided JSON representation")
  }

  static func testEqualityForJsonRepresentations<T:protocol<JSONStaticCreatable, Equatable> where T.JSONRepresentationType == T>(theJsonRepresentation: T.JSONRepresentationType) {
    let aMappedObject = T.instanceFromJSON(theJsonRepresentation)
    XCTAssertNotNil(aMappedObject, "Mapped object not created")
    XCTAssertEqual(aMappedObject, theJsonRepresentation, "Mapped object is not same as provided source")
    XCTAssertEqual(aMappedObject?.json, theJsonRepresentation, "Mapped object json representation is not equal to source")
  }

  static func testEquality<P:JSONStaticCreatable where P.JSONRepresentationType: Equatable>(theJsonRepresentation: P.JSONRepresentationType) {
    let aMappedObject = P.instanceFromJSON(theJsonRepresentation)
    XCTAssertNotNil(aMappedObject, "Mapped object not created")
    XCTAssertEqual(aMappedObject?.json, theJsonRepresentation, "Mapped object json representation is not equal to source")
  }

}

extension JSONCreateableTests where T: JSONStringStaticCreatable {

  static func testCreationFromString(theStringRepresentation: String, theFailExpected: Bool = false) {
    let aMappedObject = T.instanceFromJSONString(theStringRepresentation)
    if theFailExpected {
      XCTAssertNil(aMappedObject, "Mapped object created even fail expected")
    } else {
      XCTAssertNotNil(aMappedObject, "Mapped object not created")
    }
  }

}

struct JSONMutableTests<T:protocol<JSONMutable, JSONStaticCreatable> where T.JSONRepresentationType: Equatable> {

  static func testAssignForJSONRepresentedObject(theJsonObject: T, newValue theNewValue: T.JSONRepresentationType) {
    var aJsonObject = theJsonObject
    aJsonObject.json = theNewValue
    XCTAssertEqual(aJsonObject.json, theNewValue, "JSON settings not updated original value")
  }

}
