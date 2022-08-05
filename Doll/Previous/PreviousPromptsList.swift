//
//  PreviousPromptsList.swift
//  Doll
//
//  Created by Dylan Elliott on 5/8/2022.
//

import Foundation
import SwiftUI


struct PreviousPromptsList: View {
    @ObservedObject var generationsManager: GenerationsManager = .shared
    var body: some View {
        NavigationView {
            List {
                ForEach(generationsManager.pastGenerations.reversed()) { generation in
                    NavigationLink {
                        PreviousPromptDetail(prompt: generation)
                    } label: {
                        HStack {
                            Image(uiImage: generation.images.randomElement()?.image ?? .init())
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 50)
                                .cornerRadius(8)
                            Text(generation.prompt)
                        }
                    }
                }
            }
            .navigationTitle("Previous Generations")
        }
    }
}
