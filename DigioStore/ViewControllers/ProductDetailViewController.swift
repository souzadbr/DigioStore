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
        
        if #available(iOS 13.0, *) {
            productDetailView.enableProductSwitch.addTarget(self, action: #selector(enableProductSwitchChanged), for: .valueChanged)
        } else {
            // Fallback para versões anteriores
            let alert = UIAlertController(title: "Atualização necessária", message: "Por favor, atualize seu iOS para a versão 13.0 ou superior para usar essa funcionalidade.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    private func configureView() {
        guard let viewModel = viewModel else { return }
        productDetailView.productNameLabel.text = viewModel.productName
        productDetailView.productDescriptionLabel.text = viewModel.productDescription
        viewModel.loadImage { [weak self] image in
            self?.productDetailView.productImageView.image = image
        }
    }
    
    @available(iOS 13.0, *)
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
    
    @available(iOS 13.0, *)
    private func showDisableAlert() {
        let alert = UIAlertController(title: nil, message: "Este produto está sendo desabilitado e não contará na próxima fatura do seu cartão Digio.", preferredStyle: .alert)
        
        let imageView = UIImageView(frame: CGRect(x: 220, y: 10, width: 40, height: 40))
        alert.view.addSubview(imageView)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}
