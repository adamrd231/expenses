//
//  DateFormatter.swift
//  ULeap
//
//  Created by differenz210 on 09/01/24.
//

import Foundation

/// `DateFormatters`
enum DateFormatters {
    static let kDateTimeFormatter = DateFormatter()
    
    static let kTwelveHourFormatStyle = "hh:mm a"
    static let kUSDateFormatStyle = "MM/dd/yy"
    static let kUSDateFormatYearFullStyle = "MM/dd/yyyy"
    static let kUSDateFullFormatStyle = "MM/dd/yyyy hh:mm:ss a"
    static let kUSDateAndTimeFormatStyle = "MM/dd/yyyy hh:mm a"
    static let kUSDateAndTimeYearShortFormatStyle = "MM/dd/yy hh:mm a"
    static let kMonthShortFormStyle = "MMM"
    static let kTwentyFourHourFormatStyle = "hh:mm"
    static let kFullTwentyFourHourFormatStyle = "HH:mm:ss"
    static let kCalendarFormatStyle = "MMM yyyy"
    static let kFullDateTwentyFourHourStyle = "yyyy-MM-dd HH:mm:ss"
    static let kMonthAndDayFormat = "MMM dd"
    static let kDayOnlyFormat = "dd"
    static let kDateTimeTwentyFourHourStyle = "yyyy-MM-dd HH:mm:ss.SSS"
    static let kFullDateOnly = "MMMM, d yyyy"
    static let kDateTimeFullMonth = "MMMM, dd yyyy - hh:mm a"
    static let kDateOnlyFullMonth = "d MMMM, yyyy"
    static let kDateOnlyShortMonth = "d MMM yyyy"
    static let kSingleDay = "d"
    static let kMonthAndSingleDayFormat = "MMM d"
    static let kTwelveHourShortFormatStyle = "h:mm a"
    static let kUSDateAndTimeFormatStyleShort = "M/d/yyyy h:mm a"
    static let kUSDateFormatYearFullShortStyle = "M/d/yyyy"
    static let kMonthAndDayAndYearFormat = "MMM d, yyyy"
    static let kMonthAndDayShortFormStyle = "d MMM"
    static let kFullMonthAndDayAndFullYear = "EEEE MMMM d, yyyy"
    static let KDayNameShort = "EEE"
    static let KDayNameLong = "EEEE"
    static let kSchedDateAndTimeFormat = "MM/dd/yy h:mm a"
    static let kSchedDateAndTimeFormatNew = "MM/dd/yy hh:mm a"
    static let kTStyle = "yyyy-MM-dd'T'HH:mm:ss"
    static let kTStyle2 = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    static let kReverseDate = "yyyy/MM/dd"
    static let kDateOnly = "yyyy-MM-dd"
    static let kYearOnly = "yyyy"
    static let kHourAndMinuteOnly = "HH:mm"
}


struct DateTimeUtility {
    
    ///`Date to String `
    static func getStringFromDateWithFormat(_ dateFormat: String, givenDate: Date) -> String {
        DateFormatters.kDateTimeFormatter.dateFormat = dateFormat
        return DateFormatters.kDateTimeFormatter.string(from: givenDate)
    }
    
    ///`String to Date`
    static func getDateFromString(_ dateFormat: String, dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: dateString) ?? Date()
    }
}

extension DateTimeUtility {
    ///`getHourAndMinutesFromDate`
    static func getHourAndMinutesFromDate(givenDate: Date) -> (String) {
        let date = givenDate
        let calendar = Calendar.current
        
        var hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        
        return "\(String(format: "%02d", hour)):\(String(format: "%02d", minute))"

    }
}
