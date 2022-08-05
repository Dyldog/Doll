//
//  SettingsViewModel.swift
//  Doll
//
//  Created by Dylan Elliott on 5/8/2022.
//

import Combine

class SettingsViewModel: ObservableObject {

    var cancellables: Set<AnyCancellable> = .init()
    
    @Published var apiKey: String = ""
    @Published var batchSize: Int = 4
    
    init() {
        apiKey = getFromUserDefaults(for: .apiKey).mapEmpty(Secrets.defaultDallEAPIKey.rawValue)
        batchSize = getFromUserDefaults(for: .batchSize) ?? 4
        
        _apiKey.projectedValue.removeDuplicates().sink {
            saveToUserDefaults($0.mapEmpty(Secrets.defaultDallEAPIKey.rawValue), forKey: .apiKey)
        }.store(in: &cancellables)
        
        _batchSize.projectedValue.removeDuplicates().sink {
            saveToUserDefaults($0, forKey: .batchSize)
        }.store(in: &cancellables)
    }
}
