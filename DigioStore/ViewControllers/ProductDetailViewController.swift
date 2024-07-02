//
//  ProductDetailViewController.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 29/06/24.
//

import UIKit

class ProductDetailViewController: UIViewController {

    private var viewModel: ProductDetailViewModelProtocol
    private let productDetailView: ProductDetailView
    init(viewModel: ProductDetailViewModelProtocol) {
        self.viewModel = viewModel
        self.productDetailView = ProductDetailView(productDetailViewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = productDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        productDetailView.configure(with: viewModel)
    }
}
