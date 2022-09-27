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
            
        }
        // TODO schedule event
        
        return event
    }
}
