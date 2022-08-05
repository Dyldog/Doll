//
//  UIImage+Temp.swift
//  Doll
//
//  Created by Dylan Elliott on 5/8/2022.
//

import UIKit

extension UIImage {
    func saveToTemporaryFile(named: String = UUID().uuidString) -> URL? {
        let url = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
            .appendingPathComponent(named, isDirectory: false)
            .appendingPathExtension("png")

        // Then write to disk
        if let data = self.pngData() {
            do {
                try data.write(to: url)
                return url
            } catch {
                print("Handle the error, i.e. disk can be full")
            }
        }
        
        return nil
    }
}
