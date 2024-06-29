//
//  ProductDetailView.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 29/06/24.
//
import UIKit

class ProductDetailView: UIView {

    let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let productNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let productDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let enableProductSwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        return switchControl
    }()
    
    let enableProductLabel: UILabel = {
        let label = UILabel()
        label.text = "Habilitar Produto"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(productImageView)
        addSubview(productNameLabel)
        addSubview(productDescriptionLabel)
        addSubview(enableProductSwitch)
        addSubview(enableProductLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            productImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: 100),
            productImageView.widthAnchor.constraint(equalToConstant: 100),
            
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
