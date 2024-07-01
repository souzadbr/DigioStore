//
//  MockDigioStoreService.swift
//  DigioStoreTests
//
//  Created by Debora Rodrigues  on 29/06/24.
//

import Foundation
@testable import DigioStore

class MockDigioStoreService: DigioStoreServiceProtocol {
    let mockData = DigioStore(
        spotlight: [Spotlight(name: "Spotlight1", bannerURL: "url1", description: "desc1")],
        products: [Products(name: "Product1", imageURL: "url1", description: "desc1")],
        cash: Cash(title: "Cash", bannerURL: "url1", description: "desc1")
    )

    func fetchDigioStore(completion: @escaping (Result<DigioStore, Error>) -> Void) {
        completion(.success(mockData))
    }
}

