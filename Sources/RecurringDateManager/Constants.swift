//
//  File.swift
//  
//
//  Created by Todd Rylaarsdam on 9/26/22.
//

import Foundation

public let kStorageRecurringEventsKey = "recurringEvents"

public let kConfiguredIntervals = [
    EventInterval.second.rawValue: [1000000,5000000,10000000,15000000,20000000,25000000,30000000],
    EventInterval.minute.rawValue: [100000, 200000,300000,400000,500000,600000,700000,800000,900000,1000000],
    EventInterval.hour.rawValue: [100000, 200000,300000,400000,500000,600000,700000,800000,900000,1000000],
    EventInterval.day.rawValue: [1000,2000,3000,4000,5000,6000,7000,8000,9000,10000],
    EventInterval.week.rawValue: [100,200,300,400,500,600,700,800,900,1000],
    EventInterval.month.rawValue: [100,200,300,400,500,600,700,800,900,1000]
]

public let kMonthToSecond = 2628000
public let kWeekToSecond = 604800
public let kDayToSecond = 86400
public let kHourToSecond = 3600
public let kMinuteToSecond = 60
