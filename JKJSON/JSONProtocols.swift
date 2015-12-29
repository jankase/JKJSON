//
// Created by Jan Kase on 23/12/15.
// Copyright (c) 2015 Jan Kase. All rights reserved.
//

import Foundation

/// class which can produce JSON acceptable content

protocol JSON {

  typealias JSONRepresentationType: JSONAcceptable

  var json: JSONRepresentationType { get }
}

/// Object conforming to this protocol represents valid JSON content

protocol JSONAcceptable {
}

/// Object which can be be transformed to JSON

/// Object which can be modified by JSON

protocol JSONMutable: JSON {

  var json: JSONRepresentationType { get set }

}

/// Can be created from JSON (used by extensions)

protocol JSONStaticCreatable: JSON {

  static func instanceFromJSON(jsonRepresentation: JSONRepresentationType) -> Self?

}

/// Creatable from JSON

protocol JSONCreatable: JSONStaticCreatable {

  init?(jsonRepresentation: JSONRepresentationType)

}

/// Creatable Object with default init

protocol JSONPrimitive: JSONPrimitiveImmutable, JSONMutable {

}

protocol JSONPrimitiveImmutable: JSONStaticCreatable, JSONAcceptable {

}

extension JSONStaticCreatable {

  static func instancesFromJSON(jsonRepresentation: [JSONRepresentationType]) -> [Self]? {
    let result = jsonRepresentation.map({ return instanceFromJSON($0) }).filter({ $0 != nil }).map({ return $0! })
    return result.count > 0 ? result : nil
  }

}

extension JSONCreatable {

  static func instanceFromJSON(jsonRepresentation: JSONRepresentationType) -> Self? {
    return self.init(jsonRepresentation: jsonRepresentation)
  }

}

extension JSONPrimitiveImmutable {

  var json: Self {
    get {
      return self
    }
  }

  static func instanceFromJSON(jsonRepresentation: Self) -> Self? {
    return jsonRepresentation
  }

}

extension JSONPrimitive {

  var json: Self {
    get {
      return _CopyWhenPossible(self)
    }
    set {
      self = newValue
    }
  }

  static func instanceFromJSON(jsonRepresentation: Self) -> Self? {
    return _CopyWhenPossible(jsonRepresentation)
  }
}

private func _CopyWhenPossible<T:Any>(any: T) -> T {
  if let obj = any as? NSObject where obj is NSCopying {
    return obj.copy() as! T
  }
    return any
}
