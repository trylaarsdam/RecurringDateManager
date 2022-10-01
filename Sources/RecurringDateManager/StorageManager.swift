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

func getRecurringEvents() -> [RecurringEvent] {
    let jsonDecoder = JSONDecoder()
    do {
        return try jsonDecoder.decode([RecurringEvent].self, from: defaults.object(forKey: kStorageRecurringEventsKey) as! Data)
    } catch {
        print("Error decoding userdefaults json")
        return [RecurringEvent]()
    }
}
