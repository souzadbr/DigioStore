//
//  MockProductDetailViewModel.swift
//  DigioStoreTests
//
//  Created by Debora Rodrigues  on 01/07/24.
//

import Foundation
import UIKit
@testable import DigioStore

class MockProductDetailViewModel: ProductDetailViewModelProtocol {
    var productName: String = "Mock Product"
    var productDescription: String = "Mock Description"
    
    func loadImage(using session: URLSession, completion: @escaping (UIImage?) -> Void) {
        // Simule o carregamento da imagem, retornando uma imagem ou nil
        completion(UIImage(systemName: "ImagemErro"))
    }
    
    func showBottomSheet(on viewController: UIViewController) {
        // sem implementacao
    }
    
    func showDisableAlert(on viewController: UIViewController) {
        // sem implementacao
    }
    
}


