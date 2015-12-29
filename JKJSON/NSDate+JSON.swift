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

class JSONDate: NSDate, JSONCreatable {

  static let JSONDefaultDateFormatter: NSDateFormatter = {
    var result = NSDateFormatter()
    result.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    result.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    return result
  }()

  lazy var jsonDateFormatter: NSDateFormatter = JSONDefaultDateFormatter

  override var json: String {
    return jsonDateFormatter.stringFromDate(self)
  }

  init?(jsonRepresentation theJsonRepresentation: String, dateFormatter theDateFormatter: NSDateFormatter) {
    if let newDate = theDateFormatter.dateFromString(theJsonRepresentation) {
      super.init(timeIntervalSinceReferenceDate: newDate.timeIntervalSinceReferenceDate)
      jsonDateFormatter = theDateFormatter
    } else {
      super.init()
      return nil
    }
  }

  required convenience init?(jsonRepresentation: String) {
    self.init(jsonRepresentation: jsonRepresentation, dateFormatter: JSONDate.JSONDefaultDateFormatter)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  static func instanceFromJSON(jsonRepresentation: String) -> Self? {
    return self.init(jsonRepresentation: jsonRepresentation)
  }

}