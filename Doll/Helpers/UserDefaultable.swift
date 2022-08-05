//
//  UserDefaultable.swift
//  Doll
//
//  Created by Dylan Elliott on 5/8/2022.
//

import Foundation

@propertyWrapper
struct UserDefaultable<T: Codable> {
    
    let key: String
    let initial: T
    
    var wrappedValue: T {
        get {
            guard let data = UserDefaults.standard.data(forKey: key) else { return initial }
            return (try? JSONDecoder().decode(T.self, from: data)) ?? initial
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else { return }
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    init(wrappedValue: T, key: String) {
        self.key = key
        self.initial = wrappedValue
    }
}
