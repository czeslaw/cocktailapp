//
//  ApplicationFlowCoordinatorTests.swift
//  Cocktail AppTests
//
//  Created by Piotr Nietrzebka on 27/10/2024.
//

import XCTest

final class ApplicationFlowCoordinatorTests: XCTestCase {

    private lazy var appCoordinator = AppCoordinator(application: application,
                                                     window: window)
    private let application = Application(environment: .xctests)
    private let window = UIWindow()
    private lazy var dependencyProvider = application.dependencies

    /// Test that application flow is started correctly
    func test_startsApplicationsFlow() {
        // GIVEN
        let navCtrl = window.rootViewController
        let rootVC = (navCtrl as! UINavigationController).topViewController

        // WHEN
        appCoordinator.start()

        // THEN
        XCTAssert(navCtrl!.isKind(of: UINavigationController.self))
        XCTAssert(rootVC!.isKind(of: SplashViewController.self))
    }
}
