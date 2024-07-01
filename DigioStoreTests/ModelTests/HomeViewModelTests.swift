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
    var viewModel: HomeViewModelProtocol!
    
    override func setUpWithError() throws {
        // Inicialize o serviço mock e a view model antes de cada teste
        mockService = MockDigioStoreService()
        viewModel = HomeViewModel(service: mockService)
    }
    
    override func tearDownWithError() throws {
        // Libere quaisquer recursos ou limpe qualquer estado global após cada teste
        mockService = nil
        viewModel = nil
    }
    
    func testInitialization() throws {
        XCTAssertEqual(viewModel.greetingText, "Olá, Maria")
        XCTAssertEqual(viewModel.productsLabelText, "Produtos")
    }
    
    func testFetchDigioStore() throws {
        let expectation = self.expectation(description: "Fetch Digio Store")
        viewModel.fetchDigioStore {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
        
        XCTAssertEqual(viewModel.spotlightCount, mockService.mockData.spotlight.count)
        XCTAssertEqual(viewModel.productsCount, mockService.mockData.products.count)
    }
    
    func testSpotlightURL() throws {
        viewModel.fetchDigioStore {
            XCTAssertEqual(self.viewModel.spotlightURL(at: 0)?.absoluteString, "https://example.com/banner1")
            XCTAssertEqual(self.viewModel.spotlightURL(at: 1)?.absoluteString, "https://example.com/banner2")
        }
    }
    
    func testProductURL() throws {
        viewModel.fetchDigioStore {
            XCTAssertEqual(self.viewModel.productURL(at: 0)?.absoluteString, "https://example.com/image1")
            XCTAssertEqual(self.viewModel.productURL(at: 1)?.absoluteString, "https://example.com/image2")
        }
    }
    
    func testProductAtIndex() throws {
        viewModel.fetchDigioStore {
            XCTAssertEqual(self.viewModel.product(at: 0)?.name, "Product 1")
            XCTAssertEqual(self.viewModel.product(at: 1)?.name, "Product 2")
        }
    }
    
    func testCashBannerURL() throws {
        viewModel.fetchDigioStore {
            XCTAssertEqual(self.viewModel.cashBannerURL()?.absoluteString, "https://example.com/cash")
        }
    }
    
}
