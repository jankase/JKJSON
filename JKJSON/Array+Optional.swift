//
// Created by Jan Kase on 04/01/16.
// Copyright (c) 2016 Jan Kase. All rights reserved.
//

import Foundation

extension Array {

  mutating func setOptionalObject(theObject: Element?, index theIndex: Index) throws {
    if let aObject = theObject {
      if theIndex < self.endIndex {
        self[theIndex] = aObject
      } else if theIndex == self.endIndex {
        self.append(aObject)
      } else {
        throw JSONErrors.ArrayOutOfBounds
      }
    }
  }

  mutating func appendOptional(theObject: Element?) {
    if let aObject = theObject {
      self.append(aObject)
    }
  }

}

extension Optional where Wrapped: protocol<RangeReplaceableCollectionType, MutableCollectionType> {

  mutating func setOptionalObject(theObject: Wrapped.Generator.Element?, index theIndex: Int) throws {

    if let aObject = theObject {

      if self == nil && theIndex == 0 {
        self = Wrapped()
      } else {
        throw JSONErrors.ArrayOutOfBounds
      }

      if var anArray = self as? Array<Wrapped.Generator.Element> {
        if anArray.endIndex > theIndex {
          anArray[theIndex] = aObject
        } else if anArray.endIndex == theIndex {
          anArray.appendOptional(aObject)
        } else {
          throw JSONErrors.ArrayOutOfBounds
        }
        if let aWrapped = anArray as? Wrapped {
          self = aWrapped
        }
      }

    }

  }

  mutating func append(theObject: Wrapped.Generator.Element?) {

    if let aObject = theObject {

      if self == nil {
        self = Wrapped()
      }

      if var anArray = self as? Array<Wrapped.Generator.Element> {
        anArray.append(aObject)
        if let aWrapped = anArray as? Wrapped {
          self = aWrapped
        }
      }

    }

  }

}
