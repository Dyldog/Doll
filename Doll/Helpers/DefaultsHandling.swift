//
//  DefaultsHandling.swift
//  Doll
//
//  Created by Dylan Elliott on 5/8/2022.
//

import Foundation

protocol DefaultsHandling {
    associatedtype Key
}

extension DefaultsHandling where Key: RawRepresentable, Key.RawValue == String {
    func getFromUserDefaults<T: Codable>(for key: Key) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key.rawValue) else { return nil }
        return (try? JSONDecoder().decode(T.self, from: data))
    }
    
    func saveToUserDefaults<T: Codable>(_ value: T, forKey key: Key) {
        guard let data = try? JSONEncoder().encode(value) else { return }
        UserDefaults.standard.set(data, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
}
