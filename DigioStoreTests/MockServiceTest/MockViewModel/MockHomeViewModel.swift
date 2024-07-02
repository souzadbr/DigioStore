//
//  MockHomeViewModel.swift
//  DigioStoreTests
//
//  Created by Debora Rodrigues  on 02/07/24.
//

import UIKit
@testable import DigioStore

class MockHomeViewModel: HomeViewModelProtocol {
    var products: [Products] = []
    
    var spotlightCount: Int {
        return 0
    }
    
    var productsCount: Int {
        return products.count
    }
    
    var avatarImage: UIImage? {
        return nil
    }
    
    var greetingText: String {
        return ""
    }
    
    var digioCashText: NSAttributedString {
        return NSAttributedString(string: "")
    }
    
    var productsLabelText: String {
        return ""
    }
    
    func spotlightURL(at index: Int) -> URL? {
        return nil
    }
    
    func productURL(at index: Int) -> URL? {
        return nil
    }
    
    func product(at index: Int) -> Products? {
        return products[index]
    }
    
    func fetchDigioStore(completion: @escaping () -> Void) {
        completion()
    }
    
    func cashBannerURL() -> URL? {
        return nil
    }
}
