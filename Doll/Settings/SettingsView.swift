//
//  SettingsView.swift
//  Doll
//
//  Created by Dylan Elliott on 5/8/2022.
//

import SwiftUI
import Combine


struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    
    var body: some View {
        NavigationView {
            List {
                VStack(alignment: .leading, spacing: 0) {
                    Text("API Key")
                        .font(.footnote)
                        .fontWeight(.bold)
                    TextField("API Key", text: $viewModel.apiKey)
                }
            }
            .navigationTitle("Settings")
        }
    }
}
