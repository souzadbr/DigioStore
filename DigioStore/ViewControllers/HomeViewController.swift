//
//  HomeViewController.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 28/06/24.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var coordinator: Coordinator?
    private var digioStore: DigioStore?

    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "userAvatar")
        
        return imageView
    }()

    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Olá, Maria"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let spotlightCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let digioCashLabel: UILabel = {
            let label = UILabel()
            let attributedText = NSMutableAttributedString(
                string: "digio ",
                attributes: [
                    .font: UIFont.boldSystemFont(ofSize: 24),
                    .foregroundColor: UIColor.black
                ]
            )
            attributedText.append(NSAttributedString(
                string: "Cash",
                attributes: [
                    .font: UIFont.boldSystemFont(ofSize: 24),
                    .foregroundColor: UIColor.darkGray
                ]
            ))
            label.attributedText = attributedText
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    private let cashBannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let productsLabel: UILabel = {
        let label = UILabel()
        label.text = "Produtos"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let productsCollectionView: UICollectionView = {
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
        stackView.spacing = 8 // Ajustar espaçamento entre o label e a imagem
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let extraSpaceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        fetchData()
        
        spotlightCollectionView.dataSource = self
        spotlightCollectionView.delegate = self
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
        
        spotlightCollectionView.register(SpotlightCell.self, forCellWithReuseIdentifier: SpotlightCell.reuseIdentifier)
        productsCollectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseIdentifier)
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
        
        view.addSubview(headerStackView)
        view.addSubview(mainStackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: 45),
            avatarImageView.heightAnchor.constraint(equalToConstant: 45),
            
            headerStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            mainStackView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 40),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            spotlightCollectionView.heightAnchor.constraint(equalToConstant: 200),
            cashBannerImageView.heightAnchor.constraint(equalToConstant: 120),
            cashBannerImageView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 5),
            cashBannerImageView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -5),
            productsCollectionView.heightAnchor.constraint(equalToConstant: 200),
            
            extraSpaceView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    private func fetchData() {
        let service = DigioStoreService()
        service.fetchDigioStore { [weak self] result in
            switch result {
            case .success(let digioStore):
                self?.digioStore = digioStore
                DispatchQueue.main.async {
                    self?.updateUI()
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }

    private func updateUI() {
        guard let digioStore = digioStore else { return }
        if let url = URL(string: digioStore.cash.bannerURL) {
            loadImage(from: url, into: cashBannerImageView)
        }
        spotlightCollectionView.reloadData()
        productsCollectionView.reloadData()
    }

    private func loadImage(from url: URL, into imageView: UIImageView) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
            }
        }
        task.resume()
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == spotlightCollectionView {
            return digioStore?.spotlight.count ?? 0
        } else if collectionView == productsCollectionView {
            return digioStore?.products.count ?? 0
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == spotlightCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpotlightCell.reuseIdentifier, for: indexPath) as! SpotlightCell
            if let spotlight = digioStore?.spotlight[indexPath.item], let url = URL(string: spotlight.bannerURL) {
                cell.configure(with: url)
            }
            return cell
        } else if collectionView == productsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseIdentifier, for: indexPath) as! ProductCell
            if let product = digioStore?.products[indexPath.item], let url = URL(string: product.imageURL) {
                cell.configure(with: url)
            }
            return cell
        }
        return UICollectionViewCell()
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == spotlightCollectionView {
            return CGSize(width: view.frame.width - 32, height: 200) // Ocupa toda a largura da tela com margem
        } else if collectionView == productsCollectionView {
            return CGSize(width: 100, height: 100) // Ajuste o tamanho conforme necessário
        }
        return CGSize(width: 200, height: 200)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
