//
//  DigioStoreService.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 28/06/24.
//

import Foundation

class DigioStoreService: DigioStoreServiceProtocol {
    
    func fetchDigioStore(completion: @escaping (Result<DigioStore, Error>) -> Void) {
        let urlString = "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/sandbox/products"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let digioStore = try JSONDecoder().decode(DigioStore.self, from: data)
                completion(.success(digioStore))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
