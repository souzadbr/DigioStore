//
//  Loading.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 28/06/24.
//

//import UIKit
//
//class LoadingView: UIView {
//    
//    private let activityIndicator: UIActivityIndicatorView = {
//        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
//        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//        activityIndicator.color = .black
//        activityIndicator.backgroundColor = .clear // Define o fundo transparente
//        activityIndicator.hidesWhenStopped = false
//        activityIndicator.startAnimating()
//        return activityIndicator
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupViews() {
//        addSubview(activityIndicator)
//        
//        NSLayoutConstraint.activate([
//            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
//            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
//        ])
//        
//        // Defina as constraints para dimensionar o LoadingView
//        translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            widthAnchor.constraint(equalToConstant: 100),
//            heightAnchor.constraint(equalToConstant: 100)
//        ])
//    }
//    
//    func startAnimating() {
//        activityIndicator.startAnimating()
//    }
//    
//    func stopAnimating() {
//        activityIndicator.stopAnimating()
//    }
//}
