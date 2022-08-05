//
//  DollApp.swift
//  Doll
//
//  Created by Dylan Elliott on 5/8/2022.
//

import SwiftUI

@main
struct DollApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem { Label("Generate", systemImage: "wand.and.rays") }
                
                PreviousPromptsList()
                    .tabItem { Label("Previous", systemImage: "arrow.counterclockwise") }
                
                SettingsView(viewModel: .init())
                    .tabItem { Label("Settings", systemImage: "gear") }
            }
        }
    }
}
