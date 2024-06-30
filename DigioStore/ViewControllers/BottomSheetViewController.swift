//
//  BottomSheetViewController.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 29/06/24.
//

import UIKit

class BottomSheetViewController: UIViewController {
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Obrigado por habilitar o produto na loja!"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contactLabel: UILabel = {
        let label = UILabel()
        label.text = "Para dúvidas, entre em contato conosco:"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Telefone: (11) 1234-5678"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email: atendimento@digio.com.br"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Fechar", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(messageLabel)
        view.addSubview(contactLabel)
        view.addSubview(phoneLabel)
        view.addSubview(emailLabel)
        view.addSubview(closeButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            contactLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            contactLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contactLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            phoneLabel.topAnchor.constraint(equalTo: contactLabel.bottomAnchor, constant: 10),
            phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            phoneLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            emailLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 10),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            closeButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            closeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
