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
        productDetailView.enableProductSwitch.addTarget(self, action: #selector(enableProductSwitchChanged), for: .valueChanged)
    }

    private func configureView() {
        guard let viewModel = viewModel else { return }
        productDetailView.productNameLabel.text = viewModel.productName
        productDetailView.productDescriptionLabel.text = viewModel.productDescription
        viewModel.loadImage { [weak self] image in
            self?.productDetailView.productImageView.image = image
        }
    }

    @objc private func enableProductSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            showBottomSheet()
        } else {
            showDisableAlert()
        }
    }

    private func showBottomSheet() {
        let bottomSheetVC = BottomSheetViewController()
        if #available(iOS 15.0, *) {
            bottomSheetVC.modalPresentationStyle = .pageSheet
            if let sheet = bottomSheetVC.sheetPresentationController {
                sheet.detents = [.medium()]
            }
        } else {
            bottomSheetVC.modalPresentationStyle = .overFullScreen
        }
        present(bottomSheetVC, animated: true, completion: nil)
    }

    private func showDisableAlert() {
        let alert = UIAlertController(title: nil, message: "Este produto está sendo desabilitado e não contará na próxima fatura do seu cartão Digio.", preferredStyle: .alert)
        
        if #available(iOS 13.0, *) {
            let imageView = UIImageView(frame: CGRect(x: 220, y: 10, width: 40, height: 40))
            imageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
            imageView.tintColor = .red
            alert.view.addSubview(imageView)
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}
