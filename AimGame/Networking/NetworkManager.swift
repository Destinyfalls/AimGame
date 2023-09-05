//
//  NetworkManager.swift
//  AimGame
//
//  Created by Igor Belobrov on 02.09.2023.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    let url = URL(string: "https://2llctw8ia5.execute-api.us-west-1.amazonaws.com/prod")!
    
    func getResult(completion: @escaping (Result?) -> ()) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error  in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(Result.self, from: data)
                completion(result)
            } catch {
                print("Error decoding == \(error)")
            }
        }
        task.resume()
    }
}
