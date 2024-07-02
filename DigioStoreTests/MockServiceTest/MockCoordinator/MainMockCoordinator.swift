//
//  MainMockCoordinator.swift
//  DigioStoreTests
//
//  Created by Debora Rodrigues  on 02/07/24.
//

import Foundation

import XCTest

@testable import DigioStore

class MockMainCoordinator: MainCoordinator {
    var didShowProductDetail = false
    var shownProdutc: Products?
    
    override func showProductDetail(with product: Products) {
        didShowProductDetail = true
        shownProdutc = product
    }
}
