//
//  ProductDetailViewModel.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 29/06/24.
//

import Foundation
import UIKit

class ProductDetailViewModel {

    private var product: Products
    
    var productName: String {
        return product.name
    }
    
    var productDescription: String {
        return product.description
    }
    
    var productImageURL: URL? {
        return URL(string: product.imageURL)
    }
    
    init(product: Products) {
        self.product = product
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        guard let url = productImageURL else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error loading image: \(error)")
                completion(nil)
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                completion(image)
            }
        }
        task.resume()
    }
}

