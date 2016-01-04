//
// Created by Jan Kase on 04/01/16.
// Copyright (c) 2016 Jan Kase. All rights reserved.
//

import Foundation

extension Dictionary {

  mutating func optionalObject(theObject: Value?, forKey theKey: Key) {
    if let aObject = theObject {
      self[theKey] = aObject
    }
  }

}

extension Optional where Wrapped: DictionaryLiteralConvertible, Wrapped.Key: Hashable {

  mutating func setObject(theObject: Wrapped.Value?, forKey theKey: Wrapped.Key) {
    if let aObject = theObject {
      if self == nil {
        self = [:]
      }
      if var anDictionary = self as? Dictionary<Wrapped.Key, Wrapped.Value> {
        anDictionary[theKey] = aObject
        if let aWrapped = anDictionary as? Wrapped {
          self = aWrapped
        }
      }
    }
  }

}
