//
//  AppCoordinator.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 28/06/24.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator.start()
    }
}
