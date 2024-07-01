//
//  ProductDetailView.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 29/06/24.
//

import UIKit

class ProductDetailView: UIView {
    
    private weak var productDetailViewModel: ProductDetailViewModelProtocol?
    
    internal let productImageView: UIImageView
    internal let productNameLabel: UILabel
    internal let productDescriptionLabel: UILabel
    internal let enableProductSwitch: UISwitch
    private var enableProductLabel: UILabel
    private let errorLabel: UILabel
    
    init(productDetailViewModel: ProductDetailViewModelProtocol) {
        self.productDetailViewModel = productDetailViewModel
        self.productImageView = UIImageView()
        self.productNameLabel = UILabel()
        self.productDescriptionLabel = UILabel()
        self.enableProductSwitch = UISwitch()
        self.enableProductLabel = UILabel()
        self.errorLabel = UILabel()
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: ProductDetailViewModelProtocol) {
        productNameLabel.text = viewModel.productName
        productDescriptionLabel.text = viewModel.productDescription
        viewModel.loadImage(using: URLSession.shared) { [weak self] image in
            guard let self = self else { return }
            if let image = image {
                self.productImageView.image = image
                self.productImageView.isHidden = false
                self.errorLabel.isHidden = true
            } else {
                self.productImageView.isHidden = true
                self.errorLabel.isHidden = false
            }
        }
    }
}

extension ProductDetailView: SetupViewCode {
    
    func setupView() {
        addSubview(productImageView)
        addSubview(productNameLabel)
        addSubview(productDescriptionLabel)
        addSubview(enableProductSwitch)
        addSubview(enableProductLabel)
        addSubview(errorLabel)
    }
    
    func configure() {
        backgroundColor = .white
        
        productImageView.contentMode = .scaleAspectFit
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        
        productNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        productDescriptionLabel.numberOfLines = 0
        productDescriptionLabel.textColor = .black
        productDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        enableProductSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        enableProductLabel.text = "Habilitar Produto"
        enableProductLabel.textColor = .black
        enableProductLabel.translatesAutoresizingMaskIntoConstraints = false
        
        errorLabel.text = "Imagem não carregada"
        errorLabel.textAlignment = .center
        errorLabel.textColor = .red
        errorLabel.font = UIFont.systemFont(ofSize: 12)
        errorLabel.numberOfLines = 0
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.isHidden = true // Iniciar oculto
    }
    
    func render() {
        productNameLabel.textColor = .black
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            productImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: 100),
            productImageView.widthAnchor.constraint(equalToConstant: 100),
            
            errorLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            errorLabel.heightAnchor.constraint(equalToConstant: 100),
            
            productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 20),
            productNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            productNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            productDescriptionLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 20),
            productDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            productDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            enableProductSwitch.topAnchor.constraint(equalTo: productDescriptionLabel.bottomAnchor, constant: 20),
            enableProductSwitch.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            enableProductLabel.centerYAnchor.constraint(equalTo: enableProductSwitch.centerYAnchor),
            enableProductLabel.leadingAnchor.constraint(equalTo: enableProductSwitch.trailingAnchor, constant: 8)
        ])
    }
    
}
