//
// Created by Jan Kase on 23/12/15.
// Copyright (c) 2015 Jan Kase. All rights reserved.
//

import Foundation

public protocol _JSON {

  var acceptableJSON: JSONAcceptable { get }

}

/// class which can produce JSON acceptable content

public protocol JSON: _JSON, JSONAcceptable {

  typealias JSONRepresentationType: JSONAcceptable

  var json: JSONRepresentationType { get }

}

/// Object conforming to this protocol represents valid JSON content

public protocol JSONAcceptable {
}

/// Object which can be be transformed to JSON

/// Object which can be modified by JSON

public protocol JSONMutable: JSON {

  var json: JSONRepresentationType { get set }

}

/// Can be created from JSON (used by extensions)

public protocol JSONStaticCreatable: JSON {

  static func instanceFromJSON(jsonRepresentation: JSONRepresentationType) -> Self?

}

/// Creatable from JSON

public protocol JSONCreatable: JSONStaticCreatable {

  init?(jsonRepresentation: JSONRepresentationType)

}

public protocol JSONStringStaticCreatable: JSONStaticCreatable {

  static func instanceFromJSONString(theJsonString: String) -> Self?

}

public protocol JSONStringCreatable: JSONStringStaticCreatable, JSONCreatable {

  init?(jsonString theJsonString: String)

}

/// Creatable Object with default init

public protocol JSONPrimitive: JSONStringStaticCreatable, JSONAcceptable, JSONMutable {

}

public extension JSONStaticCreatable {

  public static func instancesFromJSON(jsonRepresentation: [JSONRepresentationType]) -> [Self]? {
    let result = jsonRepresentation.flatMap({ return instanceFromJSON($0) })
    return result.count > 0 ? result : nil
  }

}

public extension JSON {

  public var acceptableJSON: JSONAcceptable {
    return json
  }

}

public extension JSONPrimitive {

  public var json: Self {
    get {
      return _CopyWhenPossible(self)
    }
    set {
      self = newValue
    }
  }

  public static func instanceFromJSON(jsonRepresentation: Self) -> Self? {
    return _CopyWhenPossible(jsonRepresentation)
  }

}

private func _CopyWhenPossible<T:Any>(any: T) -> T {

  if let obj = any as? NSObject where obj is NSCopying {
    return obj.copy() as! T
  }
  return any

}
