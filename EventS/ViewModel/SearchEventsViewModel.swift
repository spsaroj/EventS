//
//  EventsViewModel.swift
//  EventS
//
//  Created by Saroj Paudel on 5/7/22.
//

import Foundation
import SwiftUI

//Observable Object class
class SearchEventsViewModel: ObservableObject {
    //    Published variable so that we can use this in the View
    @Published var events: [EventsDataModel] = []
    
    //    Function to make get api call using JSON serialization
    func getEvents(searchQuery: String) {
        let clientID = InfoPListParser.getValueFromInfoPList(forKey: "SeatGeekClientID")
        let clientSecret = InfoPListParser.getValueFromInfoPList(forKey: "SeatGeekClientSecret")
        guard let url = URL(string: ApiURL.BASE_URL + "?client_id=\(clientID)&client_secret=\(clientSecret)&q=\(searchQuery)") else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                        let eventsList = json["events"] as! [[String: Any]]
                        self.loadRequiredValues(eventsLists: eventsList)
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    
    //      Function to load the required variable to an array from api response data
    func loadRequiredValues(eventsLists: [[String: Any]]) {
        //events list needs to be empty before the operation
        events = []
        eventsLists.forEach{ item in
            //Get values for id, type, date time, title
            let idOfEvent = item["id"] as! Int
            var typeOfEvent = ""
            var dateTimeEvent = ""
            var titleOfEvent = ""
            
            if let eventType = item["type"] as? String{
                typeOfEvent = eventType
            }
            if let eventDateTime = item["datetime_utc"] as? String{
                dateTimeEvent = eventDateTime
            }
            if let eventTitle = item["title"] as? String{
                titleOfEvent = eventTitle
            }
            
            //Get values for Venue
            let venue = item["venue"] as! [String: Any]
            
            var addressOfEvent = ""
            var cityOfEvent = ""
            var stateOfEvent = ""
            var countryOfEvent = ""
            if let eventAddress = venue["address"] as? String{
                addressOfEvent = eventAddress
            }
            if let eventCity = venue["city"] as? String{
                cityOfEvent = eventCity
            }
            if let eventState = venue["state"] as? String{
                stateOfEvent = eventState
            }
            if let eventCountry = venue["country"] as? String{
                countryOfEvent = eventCountry
            }
            let venueOfEvent: Venue = Venue(address: addressOfEvent, city: cityOfEvent, state: stateOfEvent, country: countryOfEvent)
            
            //Append the values in events list
            self.events.append(EventsDataModel(type: typeOfEvent, id: idOfEvent, datetime_utc: dateTimeEvent, title: titleOfEvent, venue: venueOfEvent))
        }
    }
}

