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
    
    func loadImage(completion: @escaping (UIImage?) -> Void)
    func showBottomSheet(on viewController: UIViewController)
    func showDisableAlert(on viewController: UIViewController)
    
}

class ProductDetailViewModel: ProductDetailViewModelProtocol{
    
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
    
    func showBottomSheet(on viewController: UIViewController) {
        let bottonSheeetVC = BottomSheetViewController()
        if #available(iOS 15.0, *) {
            bottonSheeetVC.modalPresentationStyle = .pageSheet
            if let bottonSheet = bottonSheeetVC.sheetPresentationController {
                bottonSheet.detents = [.medium()]
            }
        } else {
            bottonSheeetVC.modalPresentationStyle = .overFullScreen
        }
        
        viewController.present(bottonSheeetVC, animated: true, completion: nil)
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
