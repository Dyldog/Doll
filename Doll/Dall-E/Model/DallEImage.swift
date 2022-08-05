//
//  DallEImage.swift
//  Doll
//
//  Created by Dylan Elliott on 5/8/2022.
//

import UIKit

struct DallEImage: Identifiable, Codable {
    var id: String { "\(image.hashValue)" }
    let data: Data
    var image: UIImage { UIImage(data: data) ?? .init() }
    
}
