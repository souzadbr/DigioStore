//
//  HomeViewControllerTests.swift
//  DigioStoreTests
//
//  Created by Debora Rodrigues  on 02/07/24.
//

import XCTest
@testable import DigioStore

class HomeViewControllerTests: XCTestCase {
    
    var navigationController: UINavigationController!
    var mockCoordinator: MockMainCoordinator!
    var viewModel: MockHomeViewModel!
    var homeViewController: HomeViewController!
    
    override func setUp() {
        super.setUp()
        
        navigationController = UINavigationController()
        mockCoordinator = MockMainCoordinator(navigationController: navigationController)
        viewModel = MockHomeViewModel()
        homeViewController = HomeViewController(viewModel: viewModel)
        homeViewController.coordinator = mockCoordinator
        
        _ = homeViewController.view
        
    }
    
    override func tearDown() {
        navigationController = nil
        mockCoordinator = nil
        viewModel = nil
        homeViewController = nil
        
        super.tearDown()
    }
    
    func testDidSelectItemAt() {
        //given
        let product = Products(name: "Teste", imageURL: "https://exemplo.com", description: "descricao")
        viewModel.products = [product]
        
        //when
        homeViewController.collectionView(homeViewController.homeView.productsCollectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
        
        // Then
        XCTAssertTrue(mockCoordinator.didShowProductDetail, "A função showProductDetail foi chamada")
        XCTAssertEqual(mockCoordinator.shownProdutc?.name, product.name, "A tela chamada é a respectiva do produto clicado")
    }
}
