//
// Created by Jan Kase on 04/01/16.
// Copyright (c) 2016 Jan Kase. All rights reserved.
//

import Foundation

extension Array {

  mutating func setOptionalObject(theObject: Element?, index theIndex: Index) {
    if let aObject = theObject {
      self[theIndex] = aObject
    }
  }

  mutating func appedOptional(theObject: Element?) {
    if let aObject = theObject {
      self.append(aObject)
    }
  }

}

extension Optional where Wrapped: protocol<RangeReplaceableCollectionType, MutableCollectionType> {

  mutating func setOptionalObject(theObject: Wrapped.Generator.Element?, index theIndex: Int) {

    if let aObject = theObject {

      if self == nil {
        self = Wrapped()
      }

      if var anArray = self as? Array<Wrapped.Generator.Element> {
        anArray[theIndex] = aObject
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
