//
//  HomeView.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 29/06/24.
//

import UIKit

class HomeView: UIView {
    private weak var homeViewModel: HomeViewModelProtocol?

    private let avatarImageView: UIImageView
    private let greetingLabel: UILabel
    private let digioCashLabel: UILabel
    private let cashBannerImageView: UIImageView
    private let productsLabel: UILabel
    private let headerStackView: UIStackView
    private let mainStackView: UIStackView
    private let cashStackView: UIStackView
    private let extraSpaceView: UIView
    internal let spotlightCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white // Definindo cor de fundo branca
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    internal let productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    init(homeViewModel: HomeViewModelProtocol) {
        self.homeViewModel = homeViewModel
        self.greetingLabel = UILabel()
        self.avatarImageView = UIImageView()
        self.digioCashLabel = UILabel()
        self.cashBannerImageView = UIImageView()
        self.productsLabel = UILabel()
        self.headerStackView = UIStackView()
        self.mainStackView = UIStackView()
        self.cashStackView = UIStackView()
        self.extraSpaceView = UIView()
        super.init(frame: .zero)
        self.setup()
        spotlightCollectionView.register(SpotlightCell.self, forCellWithReuseIdentifier: SpotlightCell.reuseIdentifier)
        productsCollectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseIdentifier)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    internal func fetchUpdateUI() {
        homeViewModel?.fetchDigioStore { [weak self] in
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
    }
    internal func setupBindings() {
        avatarImageView.image = homeViewModel?.avatarImage
        greetingLabel.text = homeViewModel?.greetingText
        digioCashLabel.attributedText = homeViewModel?.digioCashText
        productsLabel.text = homeViewModel?.productsLabelText
    }
    internal func updateUI() {
        if let url = homeViewModel?.cashBannerURL() {
            loadImage(from: url, into: cashBannerImageView, onFailure: {
                self.cashBannerImageView.image = UIImage(named: "ImagemErro")
            })
        } else {
            cashBannerImageView.image = UIImage(named: "ImagemErro")
        }
        spotlightCollectionView.reloadData()
        productsCollectionView.reloadData()
    }
    private func loadImage(from url: URL, into imageView: UIImageView, onFailure: @escaping () -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    onFailure()
                }
                return
            }
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
            }
        }
        task.resume()
    }
}

extension HomeView: SetupViewCode {
    func setupView() {
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
    func configure() {
        greetingLabel.font = UIFont.boldSystemFont(ofSize: 20)
        greetingLabel.backgroundColor = .clear
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 30
        avatarImageView.clipsToBounds = true
        avatarImageView.backgroundColor = .clear
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        digioCashLabel.backgroundColor = .clear
        digioCashLabel.translatesAutoresizingMaskIntoConstraints = false
        cashBannerImageView.contentMode = .scaleAspectFit
        cashBannerImageView.layer.cornerRadius = 25
        cashBannerImageView.clipsToBounds = true
        cashBannerImageView.layer.masksToBounds = true
        cashBannerImageView.translatesAutoresizingMaskIntoConstraints = false
        productsLabel.font = UIFont.boldSystemFont(ofSize: 20)
        productsLabel.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.axis = .horizontal
        headerStackView.alignment = .center
        headerStackView.spacing = 8
        headerStackView.backgroundColor = .clear
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.spacing = 20
        mainStackView.backgroundColor = .clear
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        cashStackView.axis = .vertical
        cashStackView.spacing = 8
        cashStackView.backgroundColor = .clear
        cashStackView.translatesAutoresizingMaskIntoConstraints = false
        extraSpaceView.backgroundColor = .clear
        extraSpaceView.translatesAutoresizingMaskIntoConstraints = false
        // Adicionar sombras
        avatarImageView.layer.shadowColor = UIColor.black.cgColor
        avatarImageView.layer.shadowOpacity = 0.25
        avatarImageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        avatarImageView.layer.shadowRadius = 4
        cashBannerImageView.layer.shadowColor = UIColor.black.cgColor
        cashBannerImageView.layer.shadowOpacity = 0.25
        cashBannerImageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cashBannerImageView.layer.shadowRadius = 4
        spotlightCollectionView.layer.shadowColor = UIColor.black.cgColor
        spotlightCollectionView.layer.shadowOpacity = 0.25
        spotlightCollectionView.layer.shadowOffset = CGSize(width: 0, height: 2)
        spotlightCollectionView.layer.shadowRadius = 4
        productsCollectionView.layer.shadowColor = UIColor.black.cgColor
        productsCollectionView.layer.shadowOpacity = 0.25
        productsCollectionView.layer.shadowOffset = CGSize(width: 0, height: 2)
        productsCollectionView.layer.shadowRadius = 4
    }
    func render() {
        spotlightCollectionView.backgroundColor = .clear
        productsCollectionView.backgroundColor = .clear
    }
    func setupConstraints() {
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
