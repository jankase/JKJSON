//
// Created by Jan Kase on 04/01/16.
// Copyright (c) 2016 Jan Kase. All rights reserved.
//

import Foundation

extension Dictionary: JSONAcceptable, JSON {

  public var json: [String:JSONAcceptable] {
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

  public func optionalObjectForKey<T:JSONStaticCreatable>(theKey: Key,
                                                          ofType theType: T.Type,
                                                          defaultValue theDefault: T? = nil) -> T? {
    if let aValue = self[theKey] as? T.JSONRepresentationType {
      return T.instanceFromJSON(aValue) ?? theDefault
    }
    return theDefault
  }

  public func objectForKey<T:JSONStaticCreatable>(theKey: Key,
                                                  ofType theType: T.Type,
                                                  defaultValue theDefault: T) -> T {

    return optionalObjectForKey(theKey, ofType: theType, defaultValue: theDefault) ?? theDefault

  }

  public func updateObject<T:JSONMutable>(theValue: T, fromKey theKey: Key) -> T {
    if let aStoredValue = self[theKey] as? T.JSONRepresentationType {
      var aValue = theValue
      aValue.json = aStoredValue
      return aValue
    }
    return theValue
  }

}

extension Dictionary where Key: StringLiteralConvertible, Value: Any {

  var objcJson: [String:AnyObject]? {
    get {
      var aResult = [:] as [String:AnyObject]
      let json    = self.json
      for (aKey, aValue) in json {
        if let aResultValue = aValue as? AnyObject {
          aResult[String(aKey)] = aResultValue
        }
      }
      if aResult.count > 0 {
        return aResult
      } else {
        return nil
      }
    }
    set(theNewValue) {
      guard let theNewValue = theNewValue else {
        self = [:]
        return
      }
      var aNewSelf = [:] as [Key:Value]
      for (aKey, aValue) in theNewValue {
        if let aNewKey = aKey as? Key, let aNewValue = aValue as? Value {
          aNewSelf[aNewKey] = aNewValue
        }
      }
      self = aNewSelf
    }
  }

}
