//
//  TabBar.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 14/05/2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }

    private func setupViewControllers() {
        // Home View Controller Setup
        let homeViewController = HomeViewController()
        let homePresenter = HomePresenterImpl()
        homeViewController.presenter = homePresenter
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))

        // Profile View Controller Setup
        let profileViewController = UserProfileViewController()
        let profilePresenter = UserPresenterImpl()
        profileViewController.presenter = profilePresenter
        profileViewController.user = UserManager.shared.currentUser
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))

        // Menu View Controller Setup
        let menuViewController = MenuViewController()
        let menuPresenter = MenuPresenterImpl()
        menuViewController.presenter = menuPresenter
        menuViewController.tabBarItem = UITabBarItem(title: "Menu", image: UIImage(systemName: "list.dash"), selectedImage: UIImage(systemName: "list.dash.fill"))

        let controllers = [homeViewController, profileViewController, menuViewController].map {
            UINavigationController(rootViewController: $0)
        }
        self.setViewControllers(controllers, animated: false)
    }
}
