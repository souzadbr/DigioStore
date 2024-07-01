//
//  DigioStoreServiceProtocol.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 29/06/24.
//

import Foundation

protocol DigioStoreServiceProtocol {
    func fetchDigioStore(completion: @escaping (Result<DigioStore, Error>) -> Void)
    
}
