//
//  File.swift
//  
//
//  Created by Todd Rylaarsdam on 9/30/22.
//

import Foundation

public struct QueuedNotification: Identifiable, Codable {
    public var id: String
    public var eventID: String
    public var date: Date
}
