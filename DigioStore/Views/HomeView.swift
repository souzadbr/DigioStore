//
//  HomeView.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 29/06/24.
//

import UIKit

class HomeView: UIView {
    
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let greetingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let spotlightCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let digioCashLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cashBannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let productsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let cashStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let extraSpaceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        headerStackView.addArrangedSubview(avatarImageView)
        headerStackView.addArrangedSubview(greetingLabel)
        
        cashStackView.addArrangedSubview(extraSpaceView)
        cashStackView.addArrangedSubview(digioCashLabel)
        cashStackView.addArrangedSubview(cashBannerImageView)
        
        mainStackView.addArrangedSubview(spotlightCollectionView)
        mainStackView.addArrangedSubview(cashStackView)
        mainStackView.addArrangedSubview(productsLabel)
        mainStackView.addArrangedSubview(productsCollectionView)
        
        addSubview(headerStackView)
        addSubview(mainStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: 45),
            avatarImageView.heightAnchor.constraint(equalToConstant: 45),
            
            headerStackView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            mainStackView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 40),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            spotlightCollectionView.heightAnchor.constraint(equalToConstant: 200),
            cashBannerImageView.heightAnchor.constraint(equalToConstant: 120),
            cashBannerImageView.leadingAnchor.constraint(equalTo: cashStackView.leadingAnchor, constant: 0),
            cashBannerImageView.trailingAnchor.constraint(equalTo: cashStackView.trailingAnchor, constant: 0),
            productsCollectionView.heightAnchor.constraint(equalToConstant: 100),
            
            extraSpaceView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}

