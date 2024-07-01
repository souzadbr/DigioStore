//
//  DigioStoreModel.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 28/06/24.
//

import Foundation

struct DigioStore: Decodable {
    let spotlight: [Spotlight]
    let products: [Products]
    let cash: Cash  // Como os valores são iguais aos nomes dos casos, o enum `CodingKeys` pode ser omitido.
}

struct Spotlight: Decodable {
    let name: String
    let bannerURL: String
    let description: String
    
}

struct Products: Decodable {
    let name: String
    let imageURL: String
    let description: String
    
}

struct Cash: Decodable {
    let title: String
    let bannerURL: String
    let description: String
    
}

