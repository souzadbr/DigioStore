//
//  BottonSheetView.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 29/06/24.
//

import UIKit

class BottomSheetView: UIView {
    
    internal let messageLabel: UILabel
    internal let contactLabel: UILabel
    internal let phoneLabel: UILabel
    internal let emailLabel: UILabel
    internal let closeButton: UIButton
    
    override init(frame: CGRect) {
        messageLabel = UILabel()
        contactLabel = UILabel()
        phoneLabel = UILabel()
        emailLabel = UILabel()
        closeButton = UIButton(type: .system)
        
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BottomSheetView: SetupViewCode {
    
    func setupView() {
        addSubview(messageLabel)
        addSubview(contactLabel)
        addSubview(phoneLabel)
        addSubview(emailLabel)
        addSubview(closeButton)
    }
    
    func configure() {
        messageLabel.text = "Obrigado por habilitar o produto na loja!"
        messageLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contactLabel.text = "Para dúvidas, entre em contato conosco:"
        contactLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        contactLabel.numberOfLines = 0
        contactLabel.textAlignment = .center
        contactLabel.translatesAutoresizingMaskIntoConstraints = false
        
        phoneLabel.text = "Telefone: (11) 1234-5678"
        phoneLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        phoneLabel.numberOfLines = 0
        phoneLabel.textAlignment = .center
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        
        emailLabel.text = "Email: atendimento@digio.com.br"
        emailLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        emailLabel.numberOfLines = 0
        emailLabel.textAlignment = .center
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        closeButton.setTitle("Fechar", for: .normal)
        closeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func render() {
        //Adicionar elementos de cores aqui se necessario.
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            contactLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            contactLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contactLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            phoneLabel.topAnchor.constraint(equalTo: contactLabel.bottomAnchor, constant: 10),
            phoneLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            phoneLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            emailLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 10),
            emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            closeButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            closeButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            closeButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
