//
//  PastGeneration.swift
//  Doll
//
//  Created by Dylan Elliott on 5/8/2022.
//

import Foundation

struct PastGeneration: Codable, Identifiable {
    var id: String { prompt }
    let prompt: String
    let images: [DallEImage]
}
