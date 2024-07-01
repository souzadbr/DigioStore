//
//  HomeViewModelTests.swift
//  DigioStoreTests
//
//  Created by Debora Rodrigues  on 28/06/24.
//

import XCTest
@testable import DigioStore

final class HomeViewModelTests: XCTestCase {
    
    var mockService: MockDigioStoreService!
    var viewModel: HomeViewModel!
    
    override func setUpWithError() throws {
        // Inicialize o serviço mock e a view model antes de cada teste
        mockService = MockDigioStoreService()
        viewModel = HomeViewModel(service: mockService)
    }
    
    override func tearDownWithError() throws {
        // Libere quaisquer recursos ou limpe qualquer estado global após cada teste
        mockService = nil
        viewModel = nil    }
    
    func testInitialization() throws {
        let viewModel = HomeViewModel()
        XCTAssertEqual(viewModel.greetingText, "Olá, Maria")
        XCTAssertEqual(viewModel.productsLabelText, "Produtos")
    }
    
    func testFetchDigioStore() throws {
        let mockService = MockDigioStoreService()
        let viewModel = HomeViewModel(service: mockService)
        
        let expectation = self.expectation(description: "Fetch Digio Store")
        viewModel.fetchDigioStore {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
        
        XCTAssertEqual(viewModel.spotlightCount, mockService.mockData.spotlight.count)
        XCTAssertEqual(viewModel.productsCount, mockService.mockData.products.count)
    }
}
