//
//  File.swift
//  
//
//  Created by Todd Rylaarsdam on 9/26/22.
//

import Foundation

private let defaults = UserDefaults.standard

func addScheduledNotification(event: RecurringEvent, notificationID: String) {
    
}

func storeEvent(event: RecurringEvent) {
    let jsonEncoder = JSONEncoder()
    var currentList = getRecurringEvents()
    
    print("Current List:")
    print(currentList)
    
    currentList.append(event)
    do {
        defaults.set(try jsonEncoder.encode(currentList), forKey: kStorageRecurringEventsKey)
    } catch {
        print("Error saving event")
    }
}

func updateEvents(events: [RecurringEvent]) {
    let jsonEncoder = JSONEncoder()
    do {
        defaults.set(try jsonEncoder.encode(events), forKey: kStorageRecurringEventsKey)
    } catch {
        print("Error updating events")
    }
}

func storeNotification(notification: QueuedNotification) {
    let jsonEncoder = JSONEncoder()
    var currentList = getQueuedNotifications()
    
    print("Current List:")
    print(currentList)
    
    currentList.append(notification)
    do {
        defaults.set(try jsonEncoder.encode(currentList), forKey: kStorageQueuedNotificationsKey)
    } catch {
        print("Error saving notification")
    }
}

public func getQueuedNotifications() -> [QueuedNotification] {
    let jsonDecoder = JSONDecoder()
    do {
        return try jsonDecoder.decode([QueuedNotification].self, from: (defaults.object(forKey: kStorageQueuedNotificationsKey) as? Data ?? "[]".data(using: .utf8))!)
    } catch {
        print("Error decoding userdefaults json")
        return [QueuedNotification]()
    }
}

func getRecurringEvents() -> [RecurringEvent] {
    let jsonDecoder = JSONDecoder()
    do {
        return try jsonDecoder.decode([RecurringEvent].self, from: defaults.object(forKey: kStorageRecurringEventsKey) as! Data)
    } catch {
        print("Error decoding userdefaults json")
        return [RecurringEvent]()
    }
}
