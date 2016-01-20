//
// Created by Jan Kase on 24/12/15.
// Copyright (c) 2015 Jan Kase. All rights reserved.
//

import Foundation

extension String: JSONPrimitive {

  public static func instanceFromJSONString(theJsonString: String) -> String? {
    return String(theJsonString)
  }

}

extension Int: JSONPrimitive {

  public static func instanceFromJSONString(theJsonString: String) -> Int? {
    return Int(theJsonString)
  }

}

extension Int64: JSONPrimitive {

  public static func instanceFromJSONString(theJsonString: String) -> Int64? {
    return Int64(theJsonString)
  }

}

extension Int32: JSONPrimitive {

  public static func instanceFromJSONString(theJsonString: String) -> Int32? {
    return Int32(theJsonString)
  }

}

extension Int16: JSONPrimitive {

  public static func instanceFromJSONString(theJsonString: String) -> Int16? {
    return Int16(theJsonString)
  }

}

extension Int8: JSONPrimitive {

  public static func instanceFromJSONString(theJsonString: String) -> Int8? {
    return Int8(theJsonString)
  }

}

extension Bit: JSONPrimitive {

  public static func instanceFromJSONString(theJsonString: String) -> Bit? {
    if let anIntValue = Int(theJsonString) {
      return Bit(rawValue: anIntValue)
    }
    return nil
  }

}

extension UInt: JSONPrimitive {

  public static func instanceFromJSONString(theJsonString: String) -> UInt? {
    return UInt(theJsonString)
  }

}

extension UInt64: JSONPrimitive {

  public static func instanceFromJSONString(theJsonString: String) -> UInt64? {
    return UInt64(theJsonString)
  }

}

extension UInt32: JSONPrimitive {

  public static func instanceFromJSONString(theJsonString: String) -> UInt32? {
    return UInt32(theJsonString)
  }

}

extension UInt16: JSONPrimitive {

  public static func instanceFromJSONString(theJsonString: String) -> UInt16? {
    return UInt16(theJsonString)
  }

}

extension UInt8: JSONPrimitive {

  public static func instanceFromJSONString(theJsonString: String) -> UInt8? {
    return UInt8(theJsonString)
  }

}

extension Double: JSONPrimitive {

  public static func instanceFromJSONString(theJsonString: String) -> Double? {
    return Double(theJsonString)
  }

}

extension Float: JSONPrimitive {

  public static func instanceFromJSONString(theJsonString: String) -> Float? {
    return Float(theJsonString)
  }

}
