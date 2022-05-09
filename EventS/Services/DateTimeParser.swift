//
//  DateTimeParser.swift
//  EventS
//
//  Created by Saroj Paudel on 5/8/22.
//

import Foundation

//Contains functions to parse UTC time format to date and time
struct DateTimeParser {
    static func getDateFromUTC(utcTime: String) -> String {
        let splitUTC = utcTime.split(separator: "T")
        return String(splitUTC[0])
    }
    static func getTimeFromUTC(utcTime: String) -> String {
        let splitUTC = utcTime.split(separator: "T")
        let splitTime = splitUTC[1].split(separator: ":")
        let hour = splitTime[0]
        let minutes = splitTime[1]
        return "\(hour):\(minutes)"
    }
}
