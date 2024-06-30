//
//  HomeViewModel.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 29/06/24.
//

import Foundation
import UIKit

protocol HomeViewModelProtocol: AnyObject {
    var avatarImage: UIImage? { get }
    var greetingText: String { get }
    var digioCashText: NSAttributedString { get }
    var productsLabelText: String { get }
    var spotlightCount: Int { get }
    var productsCount: Int { get }
    
    func spotlightURL(at index: Int) -> URL?
    func productURL(at index: Int) -> URL?
    func product(at index: Int) -> Products?
    func fetchDigioStore(completion: @escaping () -> Void)
    func cashBannerURL() -> URL?
}

class HomeViewModel: HomeViewModelProtocol {
    private var digioStore: DigioStore?
    
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
    
    var spotlightCount: Int {
        return digioStore?.spotlight.count ?? 0
    }
    
    var productsCount: Int {
        return digioStore?.products.count ?? 0
    }
    
    func spotlightURL(at index: Int) -> URL? {
        guard let urlString = digioStore?.spotlight[index].bannerURL else { return nil }
        return URL(string: urlString)
    }
    
    func productURL(at index: Int) -> URL? {
        guard let urlString = digioStore?.products[index].imageURL else { return nil }
        return URL(string: urlString)
    }
    
    func product(at index: Int) -> Products? {
        guard let products = digioStore?.products else { return nil }
        return products[index]
    }
    
    func fetchDigioStore(completion: @escaping () -> Void) {
        let service = DigioStoreService()
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
    
    func cashBannerURL() -> URL? {
        guard let urlString = digioStore?.cash.bannerURL else { return nil }
        return URL(string: urlString)
    }
}
