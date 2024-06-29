//
//  HomeViewController.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 28/06/24.
//
import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ErrorViewControllerDelegate {
    var coordinator: Coordinator?
    private let viewModel = HomeViewModel()
    private let homeView = HomeView()

    override func loadView() {
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupBindings()
        
        homeView.spotlightCollectionView.dataSource = self
        homeView.spotlightCollectionView.delegate = self
        homeView.productsCollectionView.dataSource = self
        homeView.productsCollectionView.delegate = self
        
        homeView.spotlightCollectionView.register(SpotlightCell.self, forCellWithReuseIdentifier: SpotlightCell.reuseIdentifier)
        homeView.productsCollectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseIdentifier)
        
        NetworkMonitor.shared.startMonitoring()
        
        NotificationCenter.default.addObserver(self, selector: #selector(networkStatusChanged), name: .networkStatusChanged, object: nil)
        
        checkNetworkAndFetchData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .networkStatusChanged, object: nil)
    }

    private func setupBindings() {
        homeView.avatarImageView.image = viewModel.avatarImage
        homeView.greetingLabel.text = viewModel.greetingText
        homeView.digioCashLabel.attributedText = viewModel.digioCashText
        homeView.productsLabel.text = viewModel.productsLabelText
    }

    private func checkNetworkAndFetchData() {
        if NetworkMonitor.shared.isConnected {
            viewModel.fetchDigioStore { [weak self] in
                DispatchQueue.main.async {
                    self?.updateUI()
                }
            }
        } else {
            showErrorScreen(errorType: .noInternet)
        }
    }

    @objc private func networkStatusChanged() {
        if NetworkMonitor.shared.isConnected {
            dismissErrorScreenIfNeeded()
            checkNetworkAndFetchData()
        }
    }

    private func updateUI() {
        print("Updating UI")
        guard NetworkMonitor.shared.isConnected else {
            showErrorScreen(errorType: .noInternet)
            return
        }

        if let url = viewModel.cashBannerURL() {
            loadImage(from: url, into: homeView.cashBannerImageView)
        }
        homeView.spotlightCollectionView.reloadData()
        homeView.productsCollectionView.reloadData()
    }

    private func loadImage(from url: URL, into imageView: UIImageView) {
        print("Loading image from URL: \(url)")
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.showErrorScreen(errorType: .unknown)
                }
                return
            }
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
            }
        }
        task.resume()
    }
    
    private func showErrorScreen(errorType: ErrorViewController.ErrorType) {
        let errorVC = ErrorViewController(errorType: errorType)
        errorVC.delegate = self
        errorVC.modalPresentationStyle = .fullScreen
        present(errorVC, animated: true, completion: nil)
    }
    
    private func dismissErrorScreenIfNeeded() {
        if let presentedVC = presentedViewController as? ErrorViewController {
            presentedVC.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - ErrorViewControllerDelegate
    func didTapRetry(errorViewController: ErrorViewController) {
        if NetworkMonitor.shared.isConnected {
            errorViewController.dismiss(animated: true) {
                self.checkNetworkAndFetchData()
            }
        } else {
            errorViewController.configureErrorView()
        }
    }

    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == homeView.spotlightCollectionView {
            return viewModel.spotlightCount
        } else if collectionView == homeView.productsCollectionView {
            return viewModel.productsCount
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == homeView.spotlightCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpotlightCell.reuseIdentifier, for: indexPath) as! SpotlightCell
            if let url = viewModel.spotlightURL(at: indexPath.item) {
                cell.configure(with: url)
            }
            return cell
        } else if collectionView == homeView.productsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseIdentifier, for: indexPath) as! ProductCell
            if let url = viewModel.productURL(at: indexPath.item) {
                cell.configure(with: url)
            }
            return cell
        }
        return UICollectionViewCell()
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == homeView.spotlightCollectionView {
            return CGSize(width: view.frame.width - 32, height: 200)
        } else if collectionView == homeView.productsCollectionView {
            return CGSize(width: 100, height: 100)
        }
        return CGSize(width: 200, height: 200) // Valor padrão para o caso de erro
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == homeView.productsCollectionView {
            return 15
        }
        return 16
    }
}
