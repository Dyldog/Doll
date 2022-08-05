//
//  SettingsViewModel.swift
//  Doll
//
//  Created by Dylan Elliott on 5/8/2022.
//

import Combine

class SettingsViewModel: ObservableObject, DefaultsHandling {
    enum Key: String {
        case apiKey = "DALLE_API_KEY"
    }

    var cancellables: Set<AnyCancellable> = .init()
    
    @Published var apiKey: String = ""
    
    init() {
        apiKey = getFromUserDefaults(for: .apiKey).mapEmpty(Secrets.defaultDallEAPIKey.rawValue)
        
        _apiKey.projectedValue.removeDuplicates().sink { [weak self] in
            self?.saveToUserDefaults($0.mapEmpty(Secrets.defaultDallEAPIKey.rawValue), forKey: .apiKey)
        }.store(in: &cancellables)
    }
}
