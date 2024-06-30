//
//  ProductDetailViewController.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 29/06/24.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    var viewModel: ProductDetailViewModelProtocol? {
        didSet {
            configureView()
        }
    }
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
        navigationItem.title = "Produto"
        productDetailView.enableProductSwitch.addTarget(self, action: #selector(enableProductSwitchChanged), for: .valueChanged)
        configureView()
    }
    
    private func configureView() {
        guard let viewModel = viewModel else { return }
        productDetailView.productNameLabel.text = viewModel.productName
        productDetailView.configure(with: viewModel)
    }
    
    @objc private func enableProductSwitchChanged(_ sender: UISwitch) {
        guard let viewModel = viewModel else { return }
        if sender.isOn {
            viewModel.showBottomSheet(on: self)
        } else {
            viewModel.showDisableAlert(on: self)
        }
    }
}




