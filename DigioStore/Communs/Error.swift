//
//  Error.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 28/06/24.
//

import UIKit

class ErrorViewController: UIViewController {

    enum ErrorType {
        case unknown
        case noInternet
    }
    
    private let errorType: ErrorType
    
    
    init(errorType: ErrorType) {
           self.errorType = errorType
           super.init(nibName: nil, bundle: nil)
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}
