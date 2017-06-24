//
//  Date+Category.swift
//  ly
//   _
//  | |      /\   /\
//  | |      \ \_/ /
//  | |       \_~_/
//  | |        / \
//  | |__/\    [ ]
//  |_|__,/    \_/
//
//  Created by 李勇 on 2017/6/5.
//  Copyright © 2017年 ly. All rights reserved.
//

import Foundation

let D_MINUTE : Double = 60
let D_HOUR : Double = 3600
let D_DAY : Double = 86400
let D_WEEK : Double  = 604800
let D_YEAR : Double = 31556926

let unitFlags = Set<Calendar.Component>([.year, .month, .day, .hour, .minute, .second, .weekOfMonth, .weekday, .weekdayOrdinal])
let calendar = Calendar.current


extension Date{
    
    // MARK: - DATE
    
    //从当前时间起几天后
    static func dateWithDaysAfterNow(days: Double) -> Date {
        let aTimeInterval = Date.timeIntervalSinceReferenceDate + days * D_DAY
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        return newDate
    }
    //从当前时间起几天前
    static func dateWithDaysBeforeNow(days: Double) -> Date {
        let aTimeInterval = Date.timeIntervalSinceReferenceDate - days * D_DAY
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        return newDate
    }
    //从当前时间起几小时后
    static func dateWithHoursAfterNow(hours: Double) -> Date {
        let aTimeInterval = Date.timeIntervalSinceReferenceDate + hours * D_HOUR
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        return newDate
    }
    //从当前时间起几小时前
    static func dateWithHoursBeforeNow(hours: Double) -> Date {
        let aTimeInterval = Date.timeIntervalSinceReferenceDate - hours * D_HOUR
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        return newDate
    }
    //从当前时间起几分钟后
    static func dateWithMinutesAfterNow(minutes: Double) -> Date {
        let aTimeInterval = Date.timeIntervalSinceReferenceDate + minutes * D_MINUTE
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        return newDate
    }
    //从当前时间起几分钟前
    static func dateWithMinutesBeforeNow(minutes: Double) -> Date {
        let aTimeInterval = Date.timeIntervalSinceReferenceDate - minutes * D_MINUTE
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        return newDate
    }
    
    //昨天
    static func dateYesterday() -> Date {
        return Date.dateWithDaysBeforeNow(days: 1)
    }
    //明天
    static func dateTomorrow() -> Date {
        return Date.dateWithDaysAfterNow(days: 1)
    }
    
    // MARK: - BOOL
    
    //比较两个时间是否为同一天
    func isSameDayIgnoreTime(aDate : Date) -> Bool {
        let components1 = calendar.dateComponents(unitFlags, from: self as Date)
        let components2 = calendar.dateComponents(unitFlags, from: aDate as Date)
        return (components1.day == components2.day && components1.month == components2.month && components1.year == components2.year)
    }
    
    //是否为今天
    func isToday() -> Bool {
        return self.isSameDayIgnoreTime(aDate: Date.date())
    }
    
    //是否为明天
    func isTomorrow() -> Bool {
        return self.isSameDayIgnoreTime(aDate: Date.dateTomorrow())
    }
    
    //是否为昨天
    func isYesterday() -> Bool {
        return self.isSameDayIgnoreTime(aDate: Date.dateYesterday())
    }
    
    //判断是否为当年同一周
    func isSameWeek(aDate : Date) -> Bool {
        let components1 = calendar.dateComponents(unitFlags, from: self as Date)
        let components2 = calendar.dateComponents(unitFlags, from: aDate)
        return components1.weekOfYear == components2.weekOfYear
    }
    
    //是否为本周
    func isThisWeek() -> Bool {
        return self.isSameWeek(aDate: Date.date())
    }
    
    //是否为下周
    func isNextWeek() -> Bool {
        let aTimeInterval = Date.timeIntervalSinceReferenceDate + D_WEEK
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        return self.isSameWeek(aDate: newDate)
    }
    
    //是否为上周
    func isLastWeek() -> Bool {
        let aTimeInterval = Date.timeIntervalSinceReferenceDate - D_WEEK
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        return self.isSameWeek(aDate: newDate)
    }
    
    //判断是否为同一年
    func isSameYear(aDate : Date) -> Bool {
        let components1 = calendar.dateComponents(unitFlags, from: self as Date)
        let components2 = calendar.dateComponents(unitFlags, from: aDate)
        return components1.year == components2.year
    }
    
    //是否为本年
    func isThisYear() -> Bool {
        return self.isSameWeek(aDate: Date.date())
    }
    
    //是否为下年
    func isNextYear() -> Bool {
        let aTimeInterval = Date.timeIntervalSinceReferenceDate + D_YEAR
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        return self.isSameYear(aDate: newDate)
    }
    
    //是否为上年
    func isLastYear() -> Bool {
        let aTimeInterval = Date.timeIntervalSinceReferenceDate - D_YEAR
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        return self.isSameYear(aDate: newDate)
    }
    
    //是否晚于某天
    func isLaterThanDate(aDate : Date) -> Bool {
        return self > aDate
    }
    //是否早于某天
    func isEarlierThanDate(aDate : Date) -> Bool {
        return self < aDate
    }
    
    // MARK: - NSINTEGER
    //与某天比较多少分钟后
    func minutesAfterDate(aDate: Date) -> NSInteger {
        let ti = self.timeIntervalSince(aDate)
        return  NSInteger(ti / D_MINUTE)
    }
    //与某天比较多少分钟前
    func minutesBeforeDate(aDate: Date) -> NSInteger {
        let ti = aDate.timeIntervalSince(self)
        return  NSInteger(ti / D_MINUTE)
    }
    //与某天比较多少小时后
    func hoursAfterDate(aDate: Date) -> NSInteger {
        let ti = self.timeIntervalSince(aDate)
        return  NSInteger(ti / D_HOUR)
    }
    //与某天比较多少小时前
    func hourssBeforeDate(aDate: Date) -> NSInteger {
        let ti = aDate.timeIntervalSince(self)
        return  NSInteger(ti / D_HOUR)
    }
    //与某天比较多少天后
    func daysAfterDate(aDate: Date) -> NSInteger {
        let ti = self.timeIntervalSince(aDate)
        return  NSInteger(ti / D_DAY)
    }
    //与某天比较多少天前
    func daysBeforeDate(aDate: Date) -> NSInteger {
        let ti = aDate.timeIntervalSince(self)
        return  NSInteger(ti / D_DAY)
    }
    
    //本年
    func year() -> NSInteger {
        let components = calendar.dateComponents(unitFlags, from: self)
        return components.year!
    }
    //本月
    func month() -> NSInteger {
        let components = calendar.dateComponents(unitFlags, from: self)
        return components.month!
    }
    //本日
    func day() -> NSInteger {
        let components = calendar.dateComponents(unitFlags, from: self)
        return components.day!
    }
    //
    func week() -> NSInteger {
        let components = calendar.dateComponents(unitFlags, from: self)
        return components.weekOfYear!
    }
    //
    func weekDay() -> NSInteger {
        let components = calendar.dateComponents(unitFlags, from: self)
        return components.weekday!
    }
    //
    func nthWeekDay() -> NSInteger {
        let components = calendar.dateComponents(unitFlags, from: self)
        return components.weekdayOrdinal!
    }
    //当前小时
    func hour() -> NSInteger {
        let components = calendar.dateComponents(unitFlags, from: self)
        return components.hour!
    }
    //当前分钟
    func minute() -> NSInteger {
        let components = calendar.dateComponents(unitFlags, from: self)
        return components.minute!
    }
    
    //本年
    static func currentYear() -> NSInteger {
        let components = calendar.dateComponents(unitFlags, from: Date())
        return components.year!
    }
    //本月
    static func currentMonth() -> NSInteger {
        let components = calendar.dateComponents(unitFlags, from: Date())
        return components.month!
    }
    //本日
    static func currentDay() -> NSInteger {
        let components = calendar.dateComponents(unitFlags, from: Date())
        return components.day!
    }
    //当前小时
    static func currentHour() -> NSInteger {
        let components = calendar.dateComponents(unitFlags, from: Date())
        return components.hour!
    }
    //当前分钟
    static func currentMinute() -> NSInteger {
        let components = calendar.dateComponents(unitFlags, from: Date())
        return components.minute!
    }
    
    
    //MARK: - String
    static func dayFormatString() -> String {
        return "MM-dd HH:mm"
    }
    static func dateFormatString() -> String {
        return "yyyy-MM-dd"
    }
    static func dateChineseFormatString() -> String {
        return "yyyy年MM月dd日"
    }
    static func shortDateFormatString() -> String {
        return "yyyyMMdd"
    }
    static func timeFormatString() -> String {
        return "HH:mm"
    }
    static func monthFormatString() -> String {
        return "yyyy-MM"
    }
    static func timestampFormatString() -> String {
        return "yyyy-MM-dd HH:mm:ss"
    }
    static func datesFormatString() -> String {
        return "yyyy-MM-dd HH:mm"
    }
    static func datesPointFormatString() -> String {
        return "yyyy.MM.dd HH:mm"
    }
    
    // MARK: timestamp to datestring
    
    //时间戳转换为时间字符串
    static func dateStringFromDate(format: String, timeStamps: String) -> String {
        if format.isEmpty || timeStamps.isEmpty{
            return ""
        }
        
        let whiteSpace = CharacterSet.whitespacesAndNewlines
        if format.trimmingCharacters(in: whiteSpace).isEmpty || timeStamps.trimmingCharacters(in: whiteSpace).isEmpty{
            return ""
        }
        
        if format == "0" || timeStamps == "0"{
            return ""
        }
        
        let date = Date(timeIntervalSince1970: Double(timeStamps)!)
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        let dateString = dateFormat.string(from: date)
        return dateString
    }
    //时间字符串转换为日期
    static func dateFromDateString(format: String, dateString: String) -> Date {
        if format.isEmpty || dateString.isEmpty{
            return Date()
        }
        let whiteSpace = CharacterSet.whitespacesAndNewlines
        if format.trimmingCharacters(in: whiteSpace).isEmpty || dateString.trimmingCharacters(in: whiteSpace).isEmpty{
            return Date()
        }
        if format == "0" || dateString == "0"{
            return Date()
        }
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        let date = dateFormat.date(from: dateString)
        if date != nil{
            return date!
        }
        return Date()
    }
    
    //日期转换为10位时间戳
    static func phpTimestamp() -> String {
        let date = Date()
        var interval = date.timeIntervalSince1970
        if interval > 140000000000{
            interval = interval / 1000
        }
        let ts = String(format:"%0.f",interval)
        return ts
    }
    
    static func dayCountInYearAndMonth(year:NSInteger, month:NSInteger) -> Int{
        switch month {
        case 1,3,5,7,8,10,12:
            return 31
        case 4,6,9,11:
            return 30
        case 2:
            if year % 400 == 0 || (year % 100 != 0 && year % 4 == 0){
                return 29
            }else{
                return 28
            }
        default:
            return 0
        }
        
    }
}

extension Date {
    
    //东八区时间 PRC
    static func date() -> Date {
        // 得到当前时间（世界标准时间 UTC/GMT）
        var date:Date = Date()
        // 获取系统时区
        let zone:TimeZone = TimeZone.current
        // 计算本地时区与 GMT 时区的时间差
        let second:Int = zone.secondsFromGMT()
        // 在 GMT 时间基础上追加时间差值，得到本地时间
        date = date.addingTimeInterval(TimeInterval(second))
        return date
    }
}

