import Foundation
import UserNotifications

public struct RecurringDateManager {
    var recurringEvents = [RecurringEvent]()
    
    public init() {
        self.recurringEvents = getRecurringEvents()
    }
    
    public func getEvents() -> [RecurringEvent] {
        return getRecurringEvents()
    }
    
    public func getNotificationsOfEvent(id: String) -> [QueuedNotification] {
        let notifications = getQueuedNotifications()
        var eventNotifications = [QueuedNotification]()
        
        notifications.forEach { item in
            if item.eventID == id {
                eventNotifications.append(item)
            }
        }
        
        return eventNotifications.sorted(by: { $0.date.compare($1.date) == .orderedAscending })
    }
    
    public func deleteEvent(id: String) {
        var currentEvents = getEvents()
        
        if let index = currentEvents.firstIndex(where: { $0.id == id }) {
            do {
                let notifications = getNotificationsOfEvent(id: id)
                
                for notification in notifications {
                    if(notification.eventID == id) {
                        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notification.id])
                    }
                }
            } catch {
                
            }
            
            currentEvents.remove(at: index)
            updateEvents(events: currentEvents)
        }
    }
    
    public func createRecurringEvent(name: String, date: Date, enabledIntervals: [EventInterval]) -> RecurringEvent {
        let event = RecurringEvent(name: name,
                                   date: date,
                                   enabledIntervals: enabledIntervals)
        var scheduledNotificationIDs = [String]()
        
        storeEvent(event: event)
        
        print("Getting times for event \(date.ISO8601Format())")
        
        event.enabledIntervals.forEach { interval in
            print("Dates for interval: \(interval.rawValue)")
            let queuedDates = calculateIntervals(interval: interval, date: event.date)
            
            queuedDates.forEach { date in
                scheduledNotificationIDs.append(self.scheduleNotification(id: UUID().uuidString, event: event, notificationDate: date.0, title: "\(name) milestone hit!", message: "You've just passed \(date.1) \(interval.rawValue)s since \(date.0.ISO8601Format())", interval: interval))
            }
            // TODO schedule event
        }
        return event
    }
    
    public func scheduleNotification(id: String, event: RecurringEvent, notificationDate: Date, title: String, message: String, interval: EventInterval) -> String {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
//                print("Notification permission verified")
                
                let content = UNMutableNotificationContent()
                
                content.title = title
                content.subtitle = message
                content.sound = UNNotificationSound.default

                // show this notification five seconds from now
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: notificationDate.timeIntervalSinceNow, repeats: false)
                let notificationID = id
                // choose a random identifier
                let request = UNNotificationRequest(identifier: notificationID, content: content, trigger: trigger)
                
                // add our notification request
                UNUserNotificationCenter.current().add(request)
                
                storeNotification(notification: QueuedNotification(id: notificationID, eventID: event.id, date: notificationDate, interval: interval))

            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        
        return id
    }
    
    public func calculateIntervals(interval: EventInterval, date: Date) -> [(Date, Int)] {
        var queuedDates = [(Date, Int)]()
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
            
            queuedDates.append((date.addingTimeInterval(Double(value * timeUnitFactor)), value))
//            print(queuedDates.last!.ISO8601Format())
        }
        
        return queuedDates
    }
}
