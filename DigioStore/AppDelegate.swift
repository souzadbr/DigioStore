//
//  AppDelegate.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 28/06/24.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13.0, *) {
            // Configuração do UIWindow no SceneDelegate
        } else {
            // Configuração do UIWindow para iOS 12 ou anterior
            window = UIWindow(frame: UIScreen.main.bounds)
            let navController = UINavigationController(rootViewController: HomeViewController())
            window?.rootViewController = navController
            window?.makeKeyAndVisible()
        }
        return true
    }
}
