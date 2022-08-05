//
//  GenerationsManager.swift
//  Doll
//
//  Created by Dylan Elliott on 5/8/2022.
//

import Foundation

class GenerationsManager: ObservableObject {

    static var shared: GenerationsManager = .init()
    @Published private(set) var pastGenerations: [PastGeneration] {
        didSet { savePastGenerations() }
    }
    
    init() {        
        guard let data = SharedDefaults.data(for: .pastGenerations) else {
            pastGenerations = []
            return
        }
        
        pastGenerations = (try? JSONDecoder().decode([PastGeneration].self, from: data)) ?? []
    }
    
    private func savePastGenerations() {
        guard let data = try? JSONEncoder().encode(pastGenerations) else { return }
        SharedDefaults.set(data: data, for: .pastGenerations)
    }
    
    func addGeneration(_ generation: PastGeneration) {
        if let existingIdx = pastGenerations.firstIndex(where: { $0.prompt == generation.prompt }) {
            let existing = pastGenerations[existingIdx]
            
            pastGenerations[existingIdx] = .init(
                prompt: existing.prompt,
                images: existing.images + generation.images
            )
        } else {
            pastGenerations += [generation]
        }
    }
}
