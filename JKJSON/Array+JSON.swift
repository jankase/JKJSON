//
// Created by Jan Kase on 01/01/16.
// Copyright (c) 2016 Jan Kase. All rights reserved.
//

import Foundation

extension Array: JSON, JSONAcceptable {
  
  public var json: [JSONAcceptable] {
    var aResult = [] as [JSONAcceptable]
    for anElement in self {
      switch anElement {
        case let aJson as _JSON:
          aResult.append(aJson.acceptableJSON)
        case let anAcceptable as JSONAcceptable:
          aResult.append(anAcceptable)
        default: break
      }
    }
    return aResult
  }

  public var objcJson: [AnyObject]? {
    var aResult = [] as [AnyObject]
    for anElement in json {
      if let anObject = anElement as? AnyObject {
        aResult.append(anObject)
      } else if let aDictionary = anElement as? [String:JSONAcceptable] {
        aResult.appendOptional(aDictionary.objcJson)
      }
    }
    if aResult.count == 0 {
      return nil
    }
    return aResult
  }
  
  public func optionalObjectAtIndex<T:JSONStaticCreatable>(theIndex: Int,
                                                           withType theType: T.Type,
                                                           defaultValue theDefaultValue: T? = nil) -> T? {
    if let aJson = self[theIndex] as? T.JSONRepresentationType {
      return T.instanceFromJSON(aJson) ?? theDefaultValue
    }
    return theDefaultValue
  }
  
  public func objectAtIndex<T:JSONStaticCreatable>(theIndex: Int,
                                                   withType theType: T.Type,
                                                   defaultValue theDefaultValue: T) -> T {
    return optionalObjectAtIndex(theIndex, withType: theType, defaultValue: theDefaultValue) ?? theDefaultValue
  }
  
  public func updateObjectValue<T:JSONMutable>(theValue: T, fromIndex theIndex: Int) -> T {
    if let aJson = self[theIndex] as? T.JSONRepresentationType {
      var aResult = theValue
      aResult.json = aJson
      return aResult
    }
    return theValue
  }
  
}
