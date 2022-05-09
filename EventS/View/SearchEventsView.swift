//
//  ContentView.swift
//  EventS
//
//  Created by Saroj Paudel on 5/7/22.
//

import SwiftUI

//Main View
struct SearchEventsView: View {
    
    @State private var searchText = ""
    @ObservedObject var searchEventsVM = SearchEventsViewModel()
    
    var body: some View {
        // Navigation View for navigation from the list of results
        NavigationView{
            VStack{
                HStack{
                    Spacer()
                    VStack{
                        Text("AWesome Search")
                            .foregroundColor(Color.white)
                            .font(Font.custom("itcmachine-medium", size: 30))
                        Text("Search Events")
                            .foregroundColor(Color.white)
                            .font(Font.custom("itcmachine-medium", size: 15))
                    }
                    .padding()
                    Spacer()
                }
                .background(Color("LogoColor"))
                
                //Search Textfield with viewmodifier
                TextField("Search Events", text: $searchText)
                    .modifier(TextFieldClearButton(text: $searchText))
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                    .onChange(of: searchText) { newValue in
                        searchEventsVM.getEvents(searchQuery: searchText)
                    }
                
                //Executes if the textfield is empty
                if(searchText != ""){
                    List(searchEventsVM.events){ items in
                        NavigationLink(destination: EventDetailView(
                            type: items.type,
                            datetime_utc: items.datetime_utc,
                            title: items.title,
                            address: items.venue.address,
                            city: items.venue.city,
                            state: items.venue.state,
                            country: items.venue.country
                        )) {
                            VStack(alignment: .leading){
                                Text("\(items.title)")
                                    .lineLimit(1)
                                    .font(Font.custom("Archivo", size: 15))
                                Text("\(items.type)")
                                    .lineLimit(1)
                                    .font(Font.custom("Archivo", size: 12))
                                    .foregroundColor(Color("IconColor"))
                            }
                        }
                    }
                }
                //Executes if the textfield is not empty
                else{
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            Text("Type your queries in the search box above.")
                                .font(Font.custom("Archivo", size: 18))
                            Spacer()
                        }
                        Image(systemName: "magnifyingglass.circle.fill")
                        Spacer()
                    }
                    .padding()
                    .background(Color.gray)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// A View Modifier for TextField for the cancel button
struct TextFieldClearButton: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        HStack {
            content
            if !text.isEmpty {
                Button(
                    action: { self.text = "" },
                    label: {
                        Image(systemName: "multiply.circle")
                            .foregroundColor(Color.red)
                    }
                )
                .padding(.vertical, 3)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchEventsView()
    }
}
