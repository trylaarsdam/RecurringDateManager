import Foundation

public struct RecurringDateManager {
    var recurringEvents = [RecurringEvent]()
    
    public init() {
        self.recurringEvents = getRecurringEvents()
    }
    
    public func createRecurringEvent(name: String, date: Date, enabledIntervals: [EventInterval]) -> RecurringEvent {
        let event = RecurringEvent(name: name,
                                   date: date,
                                   enabledIntervals: enabledIntervals)
        
        print("Getting times for event \(date.ISO8601Format())")
        
        event.enabledIntervals.forEach { interval in
            //calculate dates for next 5 years
            print("Dates for interval: \(interval.rawValue)")
            let queuedDates = calculateIntervals(interval: interval, date: event.date)
            
            // TODO schedule event
        }
        return event
    }
    
    public func calculateIntervals(interval: EventInterval, date: Date) -> [Date] {
        var queuedDates = [Date]()
        kConfiguredIntervals[interval.rawValue]?.forEach { value in
            var timeUnitFactor = 0
            switch (interval) {
            case .minute:
                timeUnitFactor = kMinuteToSecond
            case .hour:
                timeUnitFactor = kHourToSecond
            case .day:
                timeUnitFactor = kDayToSecond
            case .week:
                timeUnitFactor = kWeekToSecond
            case .month:
                timeUnitFactor = kMonthToSecond
            default:
                timeUnitFactor = 0
            }
            
            queuedDates.append(date.addingTimeInterval(Double(value * timeUnitFactor)))
            print(queuedDates.last!.ISO8601Format())
        }
        
        return queuedDates
    }
}
