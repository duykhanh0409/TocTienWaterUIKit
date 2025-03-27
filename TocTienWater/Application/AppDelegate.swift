//
//  AppDelegate.swift
//  TocTienWater
//
//  Created by Nhat on 3/6/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        let navigationController = UINavigationController()
        self.appCoordinator = AppCoordinator(navigationController: navigationController)
        self.appCoordinator?.start()
        if #available(iOS 13.0, *) {
            window.overrideUserInterfaceStyle = .light // Hoặc .dark nếu bạn muốn màu nền tối
        }
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

