//
//  String+Date.swift
//  Doll
//
//  Created by Dylan Elliott on 5/8/2022.
//

import Foundation

extension String {
    static var dateTime: String {
        let formatter: DateFormatter = .init()
        formatter.dateFormat = "yyyyMMddhhmmss"
        return formatter.string(from: .now)
    }
}
