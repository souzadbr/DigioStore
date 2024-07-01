//
//  SetupViewCode.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 29/06/24.
//

import Foundation

protocol SetupViewCode {
    func setupView()
    func configure()
    func setupConstraints()
    func render()
    func setup()
    
}

extension SetupViewCode {
    func setup() {
        setupView()
        configure()
        setupConstraints()
        render()
    }
    
}
