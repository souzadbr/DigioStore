//
//  ProductDetailViewController.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 29/06/24.
//

import UIKit

class ProductDetailViewController: UIViewController {

    var viewModel: ProductDetailViewModel? {
        didSet {
            configureView()
        }
    }
    
    private let productDetailView = ProductDetailView()

    override func loadView() {
        view = productDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Produto"
    }

    private func configureView() {
        guard let viewModel = viewModel else { return }
        productDetailView.productNameLabel.text = viewModel.productName
        productDetailView.productDescriptionLabel.text = viewModel.productDescription
        viewModel.loadImage { [weak self] image in
            self?.productDetailView.productImageView.image = image
        }
    }
}
