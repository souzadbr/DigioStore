//
//  HomeViewModel.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 29/06/24.
//

import Foundation
import UIKit

class HomeViewModel {
    private var digioStore: DigioStore?
    private let service = DigioStoreService()
    
    var avatarImage: UIImage? {
        return UIImage(named: "userAvatar")
    }
    
    var greetingText: String {
        return "Olá, Maria"
    }
    
    var digioCashText: NSAttributedString {
        let attributedText = NSMutableAttributedString(
            string: "digio ",
            attributes: [
                .font: UIFont.boldSystemFont(ofSize: 20),
                .foregroundColor: UIColor.black
            ]
        )
        attributedText.append(NSAttributedString(
            string: "Cash",
            attributes: [
                .font: UIFont.boldSystemFont(ofSize: 20),
                .foregroundColor: UIColor.darkGray
            ]
        ))
        return attributedText
    }
    
    var productsLabelText: String {
        return "Produtos"
    }
    
    func fetchDigioStore(completion: @escaping () -> Void) {
        service.fetchDigioStore { [weak self] result in
            switch result {
            case .success(let digioStore):
                self?.digioStore = digioStore
                completion()
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
    
    var spotlightCount: Int {
        return digioStore?.spotlight.count ?? 0
    }
    
    var productsCount: Int {
        return digioStore?.products.count ?? 0
    }
    
    func spotlightURL(at index: Int) -> URL? {
        guard let spotlight = digioStore?.spotlight[index] else { return nil }
        return URL(string: spotlight.bannerURL)
    }
    
    func productURL(at index: Int) -> URL? {
        guard let product = digioStore?.products[index] else { return nil }
        return URL(string: product.imageURL)
    }
    
    func cashBannerURL() -> URL? {
        guard let digioStore = digioStore else { return nil }
        return URL(string: digioStore.cash.bannerURL)
    }
}

