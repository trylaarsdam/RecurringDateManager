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

func getRecurringEvents() -> [RecurringEvent] {
    return defaults.object(forKey: kStorageRecurringEventsKey) as? [RecurringEvent] ?? [RecurringEvent]()
}
