//
//  ProductDetailViewController.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 29/06/24.
//

import UIKit

class ProductDetailViewController: UIViewController {

    var product: Products? // Modelo do produto a ser exibido

    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit // Ajuste o modo de conteúdo para manter a proporção da imagem
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let productDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let enableProductSwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        return switchControl
    }()
    
    private let enableProductLabel: UILabel = {
        let label = UILabel()
        label.text = "Habilitar Produto"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Produto"
        setupViews()
        setupConstraints()
        configureView()
    }

    private func setupViews() {
        view.addSubview(productImageView)
        view.addSubview(productNameLabel)
        view.addSubview(productDescriptionLabel)
        view.addSubview(enableProductSwitch)
        view.addSubview(enableProductLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            productImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: 100), // Ajustar a altura da imagem
            productImageView.widthAnchor.constraint(equalToConstant: 100), // Ajustar a largura da imagem

            productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 20),
            productNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            productNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            productDescriptionLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 20),
            productDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            productDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            enableProductSwitch.topAnchor.constraint(equalTo: productDescriptionLabel.bottomAnchor, constant: 20),
            enableProductSwitch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            enableProductLabel.centerYAnchor.constraint(equalTo: enableProductSwitch.centerYAnchor),
            enableProductLabel.leadingAnchor.constraint(equalTo: enableProductSwitch.trailingAnchor, constant: 8)
        ])
    }

    private func configureView() {
        guard let product = product else { return }
        productNameLabel.text = product.name
        productDescriptionLabel.text = product.description
        
        // Verifique se a URL da imagem do produto é válida
        if let url = URL(string: product.imageURL) {
            loadImage(from: url, into: productImageView)
        } else {
            print("URL inválida para o produto: \(product.imageURL)")
        }
    }

    private func loadImage(from url: URL, into imageView: UIImageView) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                return
            }
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
            }
        }
        task.resume()
    }
}
