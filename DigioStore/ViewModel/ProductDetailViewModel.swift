//
//  ProductDetailViewModel.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 29/06/24.
//

import Foundation
import UIKit

protocol ProductDetailViewModelProtocol: AnyObject {
    var productName: String { get }
    var productDescription: String { get }
    
    func loadImage(using session: URLSession, completion: @escaping (UIImage?) -> Void)
    func showBottomSheet(on viewController: UIViewController)
    func showDisableAlert(on viewController: UIViewController)
}

class ProductDetailViewModel: ProductDetailViewModelProtocol {
    
    private let product: Products
    
    init(product: Products) {
        self.product = product
    }
    
    var productName: String {
        return product.name
    }
    
    var productDescription: String {
        return product.description
    }
    
    func loadImage(using session: URLSession = URLSession.shared, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: product.imageURL) else {
            completion(nil)
            return
        }
        
        let task = session.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error loading image: \(error)")
                completion(nil)
                return
            }
            guard let data = data else {
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
    
    func showBottomSheet(on viewController: UIViewController) {
        let bottomSheetVC = BottomSheetViewController()
        if #available(iOS 15.0, *) {
            bottomSheetVC.modalPresentationStyle = .pageSheet
            if let bottomSheet = bottomSheetVC.sheetPresentationController {
                bottomSheet.detents = [.medium()]
            }
        } else {
            bottomSheetVC.modalPresentationStyle = .overFullScreen
        }
        
        viewController.present(bottomSheetVC, animated: true, completion: nil)
    }
    
    func showDisableAlert(on viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: "Este produto está sendo desabilitado e não contará na próxima fatura do seu cartão Digio.", preferredStyle: .alert)
        
        if #available(iOS 13.0, *) {
            let imageView = UIImageView(frame: CGRect(x: 220, y: 10, width: 40, height: 40))
            alert.view.addSubview(imageView)
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
}
