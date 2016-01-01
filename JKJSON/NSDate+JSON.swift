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

public class JSONDate: NSDate, JSONCreatable {

  public static let defaultDate: NSDate = NSDate.distantPast()

  public static let JSONDefaultDateFormatter: NSDateFormatter = {
    var result = NSDateFormatter()
    result.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    result.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    return result
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

  public override var classForCoder : AnyClass {
    return JSONDate.self
  }

  public override init(timeIntervalSinceReferenceDate: NSTimeInterval) {
    _realDate = JSONDate._referenceDate.dateByAddingTimeInterval(timeIntervalSinceReferenceDate)
    super.init()
  }

  public convenience init?(jsonRepresentation theJsonRepresentation: String, dateFormatter theDateFormatter: NSDateFormatter) {
    if let newDate = theDateFormatter.dateFromString(theJsonRepresentation) {
      self.init(timeIntervalSinceReferenceDate: newDate.timeIntervalSinceDate(JSONDate._referenceDate))
    } else {
      self.init()
      return nil
    }
  }

  public required convenience init?(jsonRepresentation: String) {
    self.init(jsonRepresentation: jsonRepresentation, dateFormatter: JSONDate.JSONDefaultDateFormatter)
  }

  public convenience init(date: NSDate) {
    self.init(timeIntervalSinceReferenceDate: date.timeIntervalSinceReferenceDate)
  }

  public override convenience init() {
    self.init(date: JSONDate.defaultDate)
  }

  public required init?(coder theDecoder: NSCoder) {
    self._realDate = JSONDate.defaultDate
    super.init(coder: theDecoder)
    if let date = theDecoder.decodeObjectForKey(__EncodeKeys.RealDateKey) as? NSDate {
      _realDate = date
    } else {
      return nil
    }
  }

  override public func encodeWithCoder(theCoder: NSCoder) {
    super.encodeWithCoder(theCoder)
    theCoder.encodeObject(_realDate, forKey: __EncodeKeys.RealDateKey)
  }


  public static func instanceFromJSON(jsonRepresentation: String) -> Self? {
    return self.init(jsonRepresentation: jsonRepresentation)
  }

  private var _realDate: NSDate

  private static let _referenceDate: NSDate = {
    let dc = NSDateComponents()
    dc.year = 2001
    dc.month = 1
    dc.day = 1
    dc.hour = 0
    dc.minute = 0
    dc.second = 0
    dc.timeZone = NSTimeZone(forSecondsFromGMT: 0)
    let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
    return cal.dateFromComponents(dc)!
  }()

  private struct __EncodeKeys {
    static let RealDateKey = "RealDateKey"
  }

}