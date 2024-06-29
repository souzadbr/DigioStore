//
//  Coordinator.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 28/06/24.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

extension Coordinator {
    func showProductDetail(with product: Products) {
        let detailVC = ProductDetailViewController()
        detailVC.product = product
        navigationController.pushViewController(detailVC, animated: true)
    }
}
