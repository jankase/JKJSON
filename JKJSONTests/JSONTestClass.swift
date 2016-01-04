//
// Created by Jan Kase on 04/01/16.
// Copyright (c) 2016 Jan Kase. All rights reserved.
//

@testable import JKJSON

struct JSONMock: JSONMutable, JSONCreatable, Equatable {

  var testString: String
  var testInt:    Int

  var json: [String:JSONAcceptable] {
    get {
      var aResult = [:] as [String:JSONAcceptable]
      aResult[JSONMock.StringKey] = testString
      aResult[JSONMock.IntKey] = testInt
      return aResult
    }
    set {
      let aValue = newValue as [String:JSONAcceptable]
      testString = aValue.optionalObjectForKey(JSONMock.StringKey, ofType: String.self) ?? testString
      testInt = aValue.optionalObjectForKey(JSONMock.IntKey, ofType: Int.self) ?? Int.min
    }
  }

  init(testString theTestString: String, testInt theTestInt: Int) {
    testInt = theTestInt
    testString = theTestString
  }

  init?(jsonRepresentation theJson: [String:JSONAcceptable]) {
    if let aTestInt = theJson[JSONMock.IntKey] as? Int, aTestString = theJson[JSONMock.StringKey] as? String {
      testString = aTestString
      testInt = aTestInt
    } else {
      return nil
    }
  }

  static func instanceFromJSON(theJson: [String:JSONAcceptable]) -> JSONMock? {
    return JSONMock(jsonRepresentation: theJson)
  }

  static let StringKey = "string"
  static let IntKey    = "int"

}

extension JSONMock: CustomStringConvertible, CustomDebugStringConvertible {

  var description: String {
    return self.json.description
  }

  var debugDescription: String {
    return self.description
  }

}

func ==(lhs: JSONMock, rhs: JSONMock) -> Bool {
  return lhs.testInt == rhs.testInt && lhs.testString == rhs.testString
}