//
//  EventDetailView.swift
//  EventS
//
//  Created by Saroj Paudel on 5/8/22.
//

import SwiftUI

// Detail View for particular event.
struct EventDetailView: View {
    var type: String
    var datetime_utc: String
    var title: String
    var address: String
    var city: String
    var state: String
    var country: String
    
    var body: some View {
        VStack{
            VStack{
                Text("\(title)")
                    .foregroundColor(Color.white)
                    .font(Font.custom("itcmachine-medium", size: 18))
                Text("\(type)")
                    .foregroundColor(Color.white)
                    .font(Font.custom("itcmachine-medium", size: 15))
            }
            .padding()
            .background(Color("LogoColor"))
//            .background(Color("IconColor"))
            Text("\(address), \(city) \(state). \(country)")
                .font(Font.custom("Archivo", size: 15))
                .padding()
            Text("Time: \(DateTimeParser.getTimeFromUTC(utcTime: datetime_utc))")
                .font(Font.custom("Archivo", size: 15))
            Text("Date: \(DateTimeParser.getDateFromUTC(utcTime: datetime_utc))")
                .font(Font.custom("Archivo", size: 15))
        }
        .padding()
        .background(Color("IconColor"))
    }
}
