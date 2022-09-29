import Foundation

public struct RecurringDateManager {
    var recurringEvents = [RecurringEvent]()
    
    public init() {
        self.recurringEvents = getRecurringEvents()
    }
    
    func createRecurringEvent(name: String, date: Date, enabledIntervals: [EventInterval]) -> RecurringEvent {
        let event = RecurringEvent(name: name,
                                   date: date,
                                   enabledIntervals: enabledIntervals)
        
        event.enabledIntervals.forEach { interval in
            //calculate dates for next 5 years
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
                
                queuedDates.append(event.date.addingTimeInterval(Double(value * timeUnitFactor)))
            }
            
            switch (interval) {
            case .second:
                queuedDates.append(event.date.addingTimeInterval(10000))
                queuedDates.append(event.date.addingTimeInterval(20000))
                queuedDates.append(event.date.addingTimeInterval(30000))
                queuedDates.append(event.date.addingTimeInterval(40000))
                queuedDates.append(event.date.addingTimeInterval(50000))
                queuedDates.append(event.date.addingTimeInterval(60000))
                queuedDates.append(event.date.addingTimeInterval(70000))
                queuedDates.append(event.date.addingTimeInterval(80000))
                queuedDates.append(event.date.addingTimeInterval(90000))
                queuedDates.append(event.date.addingTimeInterval(100000))
            default:
                print("not implemented interval \(interval)")
            }
        }
        // TODO schedule event
        
        return event
    }
}
