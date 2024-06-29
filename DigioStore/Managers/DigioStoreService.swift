//
//  DigioStoreService.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 28/06/24.
//

import Foundation

class DigioStoreService {
  
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

////exemplo de uso que fiz em outro app
//
//final class NetworkManager{
//    
//    
//    // constante privada que recebe a URL da API
//    private let domainURLString = "https://swapi.dev/api/"
//    
//    //MARK: -fetchFilms
//    // funcao fetchFilms usa de completionHandler para fazer a chamada ao servidor de dados e aguardar o retorno enquanto o app faz outras coisas como carregar o restante da tela por exemplo.
//    func fetchFilms(completionHandler: @escaping ([Film])-> Void) {
//        //url que concatena com o final films para puxar informacoes de filmes da API
//        let url = URL(string: domainURLString + "films/")!
//        //aqui o URLSEssion é um gerenciardor de dados e o dataTasks pede dados ao URLSEssion
//        let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
//            if let error = error {
//                print("Error with fetching films: \(error)")
//            }
//            
//            guard let httpResponse = response as? HTTPURLResponse,
//                  (200...299).contains(httpResponse.statusCode) else {
//                print ("Error with the response, unexpectd status code: \(String(describing: response))")
//                return
//            }
//            
//            if let data = data,
//               let filmSummary = try? JSONDecoder().decode(FilmSummary.self, from: data) {
//                completionHandler(filmSummary.results ?? [])
//            }
//        })
//        
//        task.resume()
//    }
    
    
