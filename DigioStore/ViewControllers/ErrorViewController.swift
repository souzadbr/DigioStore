//
//  ErrorViewController.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 29/06/24.
//

import UIKit

protocol ErrorViewControllerDelegate: AnyObject {
    func didTapRetry(errorViewController: ErrorViewController)
}

class ErrorViewController: UIViewController {

    enum ErrorType {
        case unknown
        case noInternet
    }
    
    private let errorType: ErrorType
    weak var delegate: ErrorViewControllerDelegate?
    
    private let errorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tentar novamente", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("X", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    init(errorType: ErrorType) {
        self.errorType = errorType
        super.init(nibName: nil, bundle: nil)
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        configureErrorView()
    }
    
    private func setupViews() {
        view.addSubview(errorImageView)
        view.addSubview(errorMessageLabel)
        view.addSubview(retryButton)
        view.addSubview(closeButton)
        retryButton.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            errorImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            errorImageView.widthAnchor.constraint(equalToConstant: 100),
            errorImageView.heightAnchor.constraint(equalToConstant: 100),
            
            errorMessageLabel.topAnchor.constraint(equalTo: errorImageView.bottomAnchor, constant: 20),
            errorMessageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            errorMessageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            retryButton.topAnchor.constraint(equalTo: errorMessageLabel.bottomAnchor, constant: 20),
            retryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func configureErrorView() {
        switch errorType {
        case .unknown:
            if #available(iOS 13.0, *) {
                errorImageView.image = UIImage(systemName: "exclamationmark.triangle")
            } else {
                // Fallback on earlier versions
            }
            errorMessageLabel.text = "Algo deu errado. Por favor, tente novamente mais tarde."
        case .noInternet:
            if #available(iOS 13.0, *) {
                errorImageView.image = UIImage(systemName: "wifi.slash")
            } else {
                // Fallback on earlier versions
            }
            errorMessageLabel.text = "Sem conexão com a internet. Verifique sua conexão e tente novamente."
        }
    }
    
    @objc private func retryButtonTapped() {
        delegate?.didTapRetry(errorViewController: self)
    }
    
    @objc private func closeButtonTapped() {
        exit(0)
    }
}

