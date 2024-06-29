//
//  MainCoordinator.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 28/06/24.
//

import UIKit


class MainCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let firstViewController = HomeViewController()
        firstViewController.coordinator = self
        navigationController.pushViewController(firstViewController, animated: false)
    }

    func showProductDetail(with product: Products) {
        let detailVC = ProductDetailViewController()
        detailVC.product = product
        navigationController.pushViewController(detailVC, animated: true)
    }
}
