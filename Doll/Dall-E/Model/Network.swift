//
//  DallEResponses.swift
//  Doll
//
//  Created by Dylan Elliott on 5/8/2022.
//

import Foundation

struct DallEGenerateResponse: Codable {
    let id: String
}
   
struct DallETaskResponse: Codable {
    let id: String
    let status: String
    let generations: DataObject<[Generation]>?
}
        
        
extension DallETaskResponse {
    struct Generation: Codable {
        let generation: GenerationImage
    }
}

extension DallETaskResponse.Generation {
    struct GenerationImage: Codable {
        let image_path: URL
    }
}

struct DataObject<T: Codable>: Codable {
    var data: T
}
