//
//  ProductDetailViewModel.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 29/06/24.
//
import Foundation
import UIKit

class ProductDetailViewModel {
    let product: Products

    init(product: Products) {
        self.product = product
    }

    var productName: String {
        return product.name
    }

    var productDescription: String {
        return product.description
    }

    func loadImage(completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: product.imageURL) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error loading image: \(error)")
                completion(nil)
                return
            }
            guard let data = data else {
                print("No data found")
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                completion(image)
            }
        }
        task.resume()
    }
}
