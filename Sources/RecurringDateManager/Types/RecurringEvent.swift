//
//  File.swift
//  
//
//  Created by Todd Rylaarsdam on 9/26/22.
//

import Foundation

public struct RecurringEvent: Identifiable {
    public var id: String = UUID().uuidString
    public var name: String
    public var date: Date
    public var enabledIntervals: [EventInterval]
}
