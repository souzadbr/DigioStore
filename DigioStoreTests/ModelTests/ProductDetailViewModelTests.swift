//
//  ProductDetailViewModelTests.swift
//  DigioStoreTests
//
//  Created by Debora Rodrigues  on 30/06/24.
//

import XCTest
@testable import DigioStore

final class ProductDetailViewModelTests: XCTestCase {
    var product: Products!
    var viewModel: ProductDetailViewModel!
    var session: URLSession!
    
    override func setUpWithError() throws {
        product = Products(name: "Product1", imageURL: "https://example.com/sampleImage.jpg", description: "desc1")
        viewModel = ProductDetailViewModel(product: product)
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: config)
    }
    
    override func tearDownWithError() throws {
        product = nil
        viewModel = nil
        session = nil
    }
    
    func testProductDetailViewModelInitialization() throws {
        XCTAssertEqual(viewModel.productName, "Product1")
        XCTAssertEqual(viewModel.productDescription, "desc1")
    }
    
    func testProductDetailViewModelLoadImage() throws {
        let expectation = self.expectation(description: "Load Product Image")
        
        let sampleImageData = UIImage(systemName: "photo")!.pngData()
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, sampleImageData)
        }
        
        viewModel.loadImage(using: session) { image in
            XCTAssertNotNil(image, "A imagem não deveria ser nula")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}

