//
//  Theme.swift
//  SportX
//
//  Created by Zeiad Mohammed on 11/05/2026.
//

import UIKit

/// Centralized theme constants for consistent styling across the app.
/// All colors use dynamic system colors for automatic Dark Mode support.
enum Theme {

    // MARK: - Colors
    static let accentColor = UIColor.systemOrange
    static let backgroundColor = UIColor.systemBackground
    static let secondaryBackground = UIColor.secondarySystemBackground
    static let groupedBackground = UIColor.systemGroupedBackground
    static let primaryText = UIColor.label
    static let secondaryText = UIColor.secondaryLabel
    static let destructive = UIColor.systemRed

    // MARK: - Corner Radius
    static let cornerRadius: CGFloat = 12
    static let smallCornerRadius: CGFloat = 8

    // MARK: - Spacing
    static let padding: CGFloat = 16
    static let smallPadding: CGFloat = 8

    // MARK: - Shadows
    static func applyShadow(to view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.masksToBounds = false
    }

    // MARK: - Navigation Bar Styling
    static func styleNavigationBar(_ navBar: UINavigationBar) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.titleTextAttributes = [
            .foregroundColor: primaryText
        ]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: primaryText
        ]
        navBar.standardAppearance = appearance
        navBar.scrollEdgeAppearance = appearance
        navBar.tintColor = accentColor
    }

    // MARK: - Tab Bar Styling
    static func styleTabBar(_ tabBar: UITabBar) {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
        tabBar.tintColor = accentColor
    }
}
