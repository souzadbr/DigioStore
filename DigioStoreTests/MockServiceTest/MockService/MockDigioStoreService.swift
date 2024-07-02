//
//  MockDigioStoreService.swift
//  DigioStoreTests
//
//  Created by Debora Rodrigues  on 29/06/24.
//

import Foundation
@testable import DigioStore

class MockDigioStoreService: DigioStoreServiceProtocol {
    var mockData = DigioStore(
        spotlight: [
            Spotlight(name: "Spotlight 1", bannerURL: "https://example.com/banner1", description: "Description 1"),
            Spotlight(name: "Spotlight 2", bannerURL: "https://example.com/banner2", description: "Description 2")
        ],
        products: [
            Products(name: "Product 1", imageURL: "https://example.com/image1", description: "Product 1 description"),
            Products(name: "Product 2", imageURL: "https://example.com/image2", description: "Product 2 description")
        ],
        cash: Cash(title: "Cash Title", bannerURL: "https://example.com/cash", description: "Cash description")
    )
    
    func fetchDigioStore(completion: @escaping (Result<DigioStore, Error>) -> Void) {
        completion(.success(mockData))
    }
    
}
