//
//  SceneDelegate.swift
//  SportX
//
//  Created by Zeiad Mohammed on 05/05/2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Start connectivity monitor early
        _ = ConnectivityManager.shared

        let hasSeenOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")

        if hasSeenOnboarding {
            // Let the storyboard load normally — just apply styling
            // The window is automatically created from Main.storyboard via Info.plist
            if let window = window {
                styleTabBar(in: window)
            }
        } else {
            // Override the storyboard for onboarding on first launch
            window = UIWindow(windowScene: windowScene)

            let onboardingVC = OnboardingViewController(nibName: "OnboardingViewController", bundle: nil)
            onboardingVC.onFinish = { [weak self] in
                UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
                self?.transitionToMainApp()
            }
            window?.rootViewController = onboardingVC
            window?.makeKeyAndVisible()
        }
    }

    // MARK: - Transition to Main App after Onboarding

    private func transitionToMainApp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateInitialViewController() as! UITabBarController

        styleTabBar(in: tabBarController)

        UIView.transition(with: window!, duration: 0.4, options: .transitionCrossDissolve, animations: {
            self.window?.rootViewController = tabBarController
        })
    }

    // MARK: - Styling

    private func styleTabBar(in window: UIWindow) {
        if let tabBar = window.rootViewController as? UITabBarController {
            styleTabBar(in: tabBar)
        }
    }

    private func styleTabBar(in tabBarController: UITabBarController) {
        Theme.styleTabBar(tabBarController.tabBar)

        // Style each navigation bar
        tabBarController.viewControllers?.forEach { vc in
            if let nav = vc as? UINavigationController {
                Theme.styleNavigationBar(nav.navigationBar)
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
