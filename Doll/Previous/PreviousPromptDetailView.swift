//
//  PreviousPromptDetailView.swift
//  Doll
//
//  Created by Dylan Elliott on 5/8/2022.
//

import SwiftUI

struct PreviousPromptDetail: View {
    let prompt: PastGeneration
    
    var body: some View {
        List {
            ForEach(prompt.images) { image in
                ShareImage(title: prompt.prompt, image: image.image)
            }
        }
        .navigationTitle(prompt.prompt)
    }
}
