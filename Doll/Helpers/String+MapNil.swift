//
//  Optional+MapNil.swift
//  Doll
//
//  Created by Dylan Elliott on 5/8/2022.
//

import Foundation

extension String {
    func emptyAsNil() -> String? {
        if self.isEmpty {
            return nil
        } else {
            return self
        }
    }
    
    func mapEmpty(_ value: String) -> String {
        emptyAsNil() ?? value
    }
}

extension Optional where Wrapped == String {
    func mapEmpty(_ value: String) -> String {
        self?.mapEmpty(value) ?? value
    }
}
