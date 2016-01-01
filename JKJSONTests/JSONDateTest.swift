//
// Created by Jan Kase on 31/12/15.
// Copyright (c) 2015 Jan Kase. All rights reserved.
//

import Foundation
import XCTest
@testable import JKJSON

class JSONDateTest: XCTestCase {

  typealias T = JSONDate

  var jsonDateString    = JSONDateTest.__jsonDateString
  var jsonDate: NSDate  = JSONDateTest.__jsonDate
  var newJsonDateString = JSONDateTest.__jsonNewDateSting

  override func setUp() {
    super.setUp()
    jsonDateString = JSONDateTest.__jsonDateString
    jsonDate = JSONDateTest.__jsonDate
    newJsonDateString = JSONDateTest.__jsonNewDateSting
  }

  func testCreation() {
    JSONCreateableTests<T>.testCreationFromJSONRepresentation(jsonDateString)
  }

  func testBadCreation() {
    let aMappedObject = JSONDate.instanceFromJSON("XX")
    XCTAssertNil(aMappedObject, "Date created even from bad input")
  }

  func testMultipleCreation() {
    JSONCreateableTests<T>.testCreationFromMultipleJSONRepresentation([jsonDateString, newJsonDateString])
  }

  func testBadMultipleCreation() {
    let aMappedObjects = JSONDate.instancesFromJSON(["XX"])
    XCTAssertNil(aMappedObjects, "Date created even from bad input")
  }

  func testEquality() {
    let aMappedObject = T.instanceFromJSON(JSONDateTest.__jsonDateString)
    XCTAssertNotNil(aMappedObject, "Mapped object not created")
    NSLog("Reference value : \(JSONDateTest.__jsonDate), mapped value: \(aMappedObject)")
    XCTAssertEqual(aMappedObject, JSONDateTest.__jsonDate, "A mapped object not equal to source")
  }

  func testEncodingDecoding() {
    let aData      = NSMutableData()
    let anArchiver = NSKeyedArchiver(forWritingWithMutableData: aData)
    anArchiver.encodeObject(JSONDateTest.__jsonDate, forKey: "date")
    anArchiver.finishEncoding()

    let aDataForReading = aData.copy() as! NSData
    let anUnarchiver = NSKeyedUnarchiver(forReadingWithData: aDataForReading)
    let aObject = anUnarchiver.decodeObjectForKey("date")
    if let aJsonDate = aObject as? JSONDate {
      XCTAssertEqual(aJsonDate, JSONDateTest.__jsonDate, "Unarchived object does not match source object")
    } else {
      XCTFail("Failed unarchiveing object from strore")
    }
  }

  func testNSDateToJSON() {
    let aJsonDateString = JSONDateTest.__date.json
    XCTAssertEqual(aJsonDateString, JSONDateTest.__jsonDate.json, "JSON representation for plain NSDate is bad")
  }

  private static let __jsonDate: JSONDate = {
    return JSONDate(date: __date)
  }()

  private static let __date : NSDate = {
    let dc = NSDateComponents()
    dc.month = 12
    dc.year = 2015
    dc.day = 31
    dc.hour = 12
    dc.minute = 0
    dc.second = 0
    dc.timeZone = NSTimeZone(forSecondsFromGMT: 0)
    let c = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
    return c.dateFromComponents(dc)!
  }()

  private static let __jsonDateString   = "2015-12-31T12:00:00+00:00" as T.JSONRepresentationType
  private static let __jsonNewDateSting = "2016-01-01T12:00:00+00:00" as T.JSONRepresentationType

}
