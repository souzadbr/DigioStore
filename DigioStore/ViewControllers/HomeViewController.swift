//
//  HomeViewController.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 28/06/24.
//

import UIKit

class HomeViewController: UIViewController {
    var coordinator: Coordinator?
    private var digioStore: DigioStore?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Olá, Maria"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabelCash: UILabel = {
        let label = UILabel()
        label.text = "Digio Cash"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let cashBannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        fetchData()
    }

    private func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(bannerImageView)
        view.addSubview(titleLabelCash)
        view.addSubview(cashBannerImageView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            bannerImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            bannerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bannerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bannerImageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            cashBannerImageView.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: 16),
            cashBannerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cashBannerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            cashBannerImageView.heightAnchor.constraint(equalToConstant: 200)
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
        if let url = URL(string: digioStore.spotlight.first?.bannerURL ?? "") {
            loadImage(from: url, into: bannerImageView)
        }
        if let url = URL(string: digioStore.cash.bannerURL) {
            loadImage(from: url, into: cashBannerImageView)
        }
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
}
