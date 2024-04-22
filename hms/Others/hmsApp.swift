//
//  hmsApp.swift
//  hms
//
//  Created by Ishan on 22/04/24.
//

import SwiftUI
import FirebaseCore

@main
struct hmsApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
