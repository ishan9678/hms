//
//  HMS_Team_5App.swift
//  HMS-Team 5
//
//  Created by Ishan on 22/04/24.
//

import SwiftUI
import Firebase


@main
struct HMS_Team_5App: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
              NavigationView {
                AuthenticatedView {
                  Image(systemName: "number.circle.fill")
                    .resizable()
                    .frame(width: 100 , height: 100)
                    .foregroundColor(Color(.systemPink))
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .clipped()
                    .padding(4)
                    .overlay(Circle().stroke(Color.black, lineWidth: 2))
                  Text("Welcome to HMS!")
                    .font(.title)
                  Text("You need to be logged in to use this app.")
                } content: {
                    
                   ContentView()
                  Spacer()
                }
              }
            }
    }
}
