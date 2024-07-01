//
//  HomeViewController.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 28/06/24.
//
import UIKit

class HomeViewController: UIViewController {
    var coordinator: MainCoordinator?
    private var viewModel: HomeViewModelProtocol
    private let homeView: HomeView
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        self.homeView = HomeView(homeViewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        homeView.setupBindings()
        
        homeView.spotlightCollectionView.dataSource = self
        homeView.spotlightCollectionView.delegate = self
        
        homeView.productsCollectionView.dataSource = self
        homeView.productsCollectionView.delegate = self
        
        homeView.fetchUpdateUI()
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
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
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == homeView.productsCollectionView {
            guard let product = viewModel.product(at: indexPath.item) else { return }
            let productDetailViewModel = ProductDetailViewModel(product: product)
            let productDetailViewController = ProductDetailViewController(viewModel: productDetailViewModel)
            navigationController?.pushViewController(productDetailViewController, animated: true)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
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
