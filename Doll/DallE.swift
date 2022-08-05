//
//  DallE.swift
//  Doll
//
//  Created by Dylan Elliott on 5/8/2022.
//

import UIKit

class DallE: DefaultsHandling {
    enum Key: String {
        case apiKey = "DALLE_API_KEY"
    }
    
    func generate(prompt: String, batchSize: Int = 4, completion: @escaping ([DallEImage]?) -> Void) {
        let batchSize = 4
            
        requestAuthenticated(url: "https://labs.openai.com/api/labs/tasks", body: [
            "task_type": "text2im",
            "prompt": [
                "caption": prompt,
                "batch_size": batchSize,
            ]
        ]) { [weak self] (data: DallEGenerateResponse) in
            self?.getTaskResponse(id: data.id) {
                completion($0)
            }
        }
    }
    
    private func getTaskResponse(id: String, completion: @escaping ([DallEImage]) -> Void) {
        requestAuthenticated(url: "https://labs.openai.com/api/labs/tasks/\(id)") { [weak self] (data: DallETaskResponse) in
            switch data.status {
            case "succeeded":
                self?.getImages((data.generations?.data ?? []).map { $0.generation.image_path}, completion: {
                    completion($0)
                })
            case "failed":
                completion([])
            default:
                DispatchQueue.global().asyncAfter(deadline: .now() + 1) { [weak self] in
                    self?.getTaskResponse(id: id, completion: completion)
                }
            }
        }
    }
    
    private func getImages(_ urls: [URL], completion: @escaping ([DallEImage]) -> Void) {
        var images: [DallEImage] = []
        
        
        for url in urls {
            let data = try! Data(contentsOf: url)
            if UIImage(data: data) != nil {
                images.append(.init(data: data))
            }
        }
        
        completion(images)
        
    }
    
    private func requestAuthenticated<T: Decodable>(url: String, body: [String: Any]? = nil, completion: @escaping (T) -> Void) {
        let bearer: String = getFromUserDefaults(for: .apiKey) ?? Secrets.defaultDallEAPIKey.rawValue
        let headers = [
            "Authorization": "Bearer " + bearer,
            "Content-Type": "application/json",
        ]
        
        requestObject(url: url, body: body, headers: headers, completion: completion)
    }
    
    private func requestObject<T: Decodable>(url: String, body: [String: Any]? = nil, headers: [String: String] = [:], completion: @escaping (T) -> Void) {
        
        requestData(url: url, body: body, headers: headers) { data in
            completion(try! JSONDecoder().decode(T.self, from: data))
        }
    }
    
    private func requestData(url: String, body: [String: Any]? = nil, headers: [String: String] = [:], completion: @escaping (Data) -> Void) {
        var request = URLRequest(url: .init(string: url)!)
        headers.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        if let body = body {
            request.httpMethod = "POST"
            request.httpBody = try! JSONSerialization.data(withJSONObject: body)
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                fatalError("Data was nil")
            }
            
            print(String(data: data, encoding: .utf8))
            completion(data)
        }.resume()
    }
}
