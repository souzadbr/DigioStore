//
//  ProductDetailViewControllerTests.swift
//  DigioStoreTests
//
//  Created by Debora Rodrigues  on 30/06/24.
//

import XCTest
@testable import DigioStore

class MockViewModel: ProductDetailViewModelProtocol {
    var productName: String = "Test Product"
    var productDescription: String = "This is a test product description."
    
    var loadImageCompletion: ((UIImage?) -> Void)?
    
    func loadImage(using session: URLSession = URLSession.shared, completion: @escaping (UIImage?) -> Void) {
        loadImageCompletion = completion
    }
    
    func showBottomSheet(on viewController: UIViewController) {
        let bottomSheetVC = BottomSheetViewController()
        viewController.present(bottomSheetVC, animated: true, completion: nil)
    }
    
    func showDisableAlert(on viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: "Este produto está sendo desabilitado e não contará na próxima fatura do seu cartão Digio.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
}

class ProductDetailViewControllerTests: XCTestCase {
    
    var viewController: ProductDetailViewController!
    var mockViewModel: MockViewModel!
    
    override func setUpWithError() throws {
        mockViewModel = MockViewModel()
        viewController = ProductDetailViewController(viewModel: mockViewModel)
        _ = viewController.view // Carrega a view para testes
    }
    
    override func tearDownWithError() throws {
        viewController = nil
        mockViewModel = nil
    }
    
    func testBottomSheetPresentation() throws {
        let expectation = self.expectation(description: "Present Bottom Sheet")
        
        viewController.productDetailView.enableProductSwitch.isOn = true
        viewController.enableProductSwitchChanged(viewController.productDetailView.enableProductSwitch)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.viewController.presentedViewController is BottomSheetViewController)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testBottomSheetDismissal() throws {
        let bottomSheetVC = BottomSheetViewController()
        
        let expectation = self.expectation(description: "Dismiss Bottom Sheet")
        
        viewController.present(bottomSheetVC, animated: false) {
            bottomSheetVC.getCloseButton().sendActions(for: .touchUpInside)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNil(self.viewController.presentedViewController)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
