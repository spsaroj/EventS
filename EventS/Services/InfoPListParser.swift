//
//  InfoPListParser.swift
//  EventS
//
//  Created by Saroj Paudel on 5/7/22.
//

import Foundation

// Gets and parses the value from info.plist which contains client secret and client id
struct InfoPListParser {
    static func getValueFromInfoPList(forKey key: String) -> String {
        guard let value = Bundle.main.infoDictionary?[key] as? String else{
            fatalError("Couldn't find \(key) in the InfoPList")
        }
        return value
    }
}
