//
//  EventsDataModel.swift
//  EventS
//
//  Created by Saroj Paudel on 5/7/22.
//

import Foundation

// Event Data Model
struct EventsDataModel: Codable, Identifiable {
    let type: String
    let id: Int
    let datetime_utc: String
    let title: String
    let venue: Venue
}

struct Venue: Codable{
    let address: String
    let city: String
    let state: String
    let country: String
}
