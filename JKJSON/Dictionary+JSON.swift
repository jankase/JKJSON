//
// Created by Jan Kase on 04/01/16.
// Copyright (c) 2016 Jan Kase. All rights reserved.
//

import Foundation

extension Dictionary: JSONAcceptable, JSON {

  var json: [String:JSONAcceptable] {
    var aResult = [:] as [String:JSONAcceptable]
    contentLoop: for (key, value) in self {
      var aResultKey: String
      switch key {
        case let aString as String:
          aResultKey = aString
        case let aDescription as CustomStringConvertible:
          aResultKey = aDescription.description
        default: break contentLoop
      }
      switch value {
        case let aJson as _JSON:
          aResult[aResultKey] = aJson.acceptableJSON
        case let anAcceptable as JSONAcceptable:
          aResult[aResultKey] = anAcceptable
        default: break
      }
    }
    return aResult
  }

  func optionalObjectForKey<T:JSONStaticCreatable>(theKey: Key, ofType theType: T.Type, defaultValue theDefault: T? = nil) -> T? {
    if let aValue = self[theKey] as? T.JSONRepresentationType {
      return T.instanceFromJSON(aValue) ?? theDefault
    }
    return theDefault
  }

  func updateObject<T:JSONMutable>(theValue: T, fromKey theKey: Key) -> T {
    if let aStoredValue = self[theKey] as? T.JSONRepresentationType {
      var aValue = theValue
      aValue.json = aStoredValue
      return aValue
    }
    return theValue
  }

}
