//
//  AppDelegate.swift
//  Cocktail App
//
//  Created by Piotr Nietrzebka on 24/10/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private var application: Application!
    private var appCoordinator: AppCoordinator!
    var windowScene: UIWindowScene? {
        didSet {
            start()
        }
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }
    
    func start() {
        guard let scene = windowScene else {
            return
        }
        
        self.application = Application.shared
        self.appCoordinator = AppCoordinator(application: self.application,
                                             windowScene: scene)

        applyStyle()
        appCoordinator.start()
    }

    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

