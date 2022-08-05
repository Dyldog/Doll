//
//  GenerateViewModel.swift
//  Doll
//
//  Created by Dylan Elliott on 5/8/2022.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    
    private let dallE = DallE()
    
    @Published var images: [DallEImage] = []
    @Published var isSearching: Bool = false
    @Published var error: String? = nil
    
    init() {
        
    }
    
    func search(_ text: String) {
        guard text.isEmpty == false, isSearching == false else { return }
        
        isSearching = true
        
        dallE.generate(prompt: text, batchSize: getFromUserDefaults(for: .batchSize) ?? 4) { images in
            DispatchQueue.main.async {
                guard case let .success(images) = images else {
                    return
                }
                
                self.images = images
                self.isSearching = false
                self.savePrompt(text, images: self.images)
            }
        }
    }
    
    private func savePrompt(_ prompt: String, images: [DallEImage]) {
        GenerationsManager.shared.addGeneration(.init(prompt: prompt, images: images))
    }
}
