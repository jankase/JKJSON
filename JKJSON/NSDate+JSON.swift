//
// Created by Jan Kase on 27/12/15.
// Copyright (c) 2015 Jan Kase. All rights reserved.
//

import Foundation

extension NSDate: JSON {

  var json: String {
    return JSONDate.JSONDefaultDateFormatter.stringFromDate(self)
  }

}

public class JSONDate: NSDate, JSONStringCreatable {

  public static let defaultDate: NSDate = NSDate.distantPast()

  public static let JSONDefaultDateFormatter: NSDateFormatter = {
    var aResult = NSDateFormatter()
    aResult.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    aResult.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    return aResult
  }()

  public lazy var jsonDateFormatter: NSDateFormatter = JSONDefaultDateFormatter

  public override var json: String {
    return jsonDateFormatter.stringFromDate(self)
  }

  public override var timeIntervalSinceReferenceDate: NSTimeInterval {
    return _realDate.timeIntervalSinceReferenceDate
  }

  public override var description: String {
    return json
  }

  public override var classForCoder: AnyClass {
    return JSONDate.self
  }

  public override init(timeIntervalSinceReferenceDate theInterval: NSTimeInterval) {
    _realDate = JSONDate._referenceDate.dateByAddingTimeInterval(theInterval)
    super.init()
  }

  public convenience init?(jsonRepresentation theJson: String, dateFormatter theDateFormatter: NSDateFormatter) {
    if let aNewDate = theDateFormatter.dateFromString(theJson) {
      self.init(timeIntervalSinceReferenceDate: aNewDate.timeIntervalSinceDate(JSONDate._referenceDate))
    } else {
      self.init()
      return nil
    }
  }

  public required convenience init?(jsonRepresentation theJson: String) {
    self.init(jsonRepresentation: theJson, dateFormatter: JSONDate.JSONDefaultDateFormatter)
  }

  public convenience init(date theDate: NSDate) {
    self.init(timeIntervalSinceReferenceDate: theDate.timeIntervalSinceReferenceDate)
  }

  public override convenience init() {
    self.init(date: JSONDate.defaultDate)
  }

  public required init?(coder theDecoder: NSCoder) {
    _realDate = JSONDate.defaultDate
    super.init(coder: theDecoder)
    if let aDate = theDecoder.decodeObjectForKey(__EncodeKeys.RealDateKey) as? NSDate {
      _realDate = aDate
    } else {
      return nil
    }
  }

  public convenience required init?(jsonString theJsonString: String) {
    self.init(jsonRepresentation: theJsonString)
  }

  override public func encodeWithCoder(theCoder: NSCoder) {
    super.encodeWithCoder(theCoder)
    theCoder.encodeObject(_realDate, forKey: __EncodeKeys.RealDateKey)
  }

  public static func instanceFromJSON(theJson: String) -> Self? {
    return self.init(jsonRepresentation: theJson)
  }

  class func instanceFromJSONString(theJsonString: String) -> Self? {
    return self.init(jsonString: theJsonString)
  }

  private var _realDate: NSDate

  private static let _referenceDate: NSDate = {
    let aReferenceDateComponents = NSDateComponents()
    aReferenceDateComponents.year = 2001
    aReferenceDateComponents.month = 1
    aReferenceDateComponents.day = 1
    aReferenceDateComponents.hour = 0
    aReferenceDateComponents.minute = 0
    aReferenceDateComponents.second = 0
    aReferenceDateComponents.timeZone = NSTimeZone(forSecondsFromGMT: 0)
    let aGregorianCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
    return aGregorianCalendar.dateFromComponents(aReferenceDateComponents)!
  }()

  private struct __EncodeKeys {
    static let RealDateKey = "RealDateKey"
  }

}