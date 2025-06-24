//
//  BaseTabBarController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 23.06.25.
//

import UIKit

enum TabBarItems: CaseIterable {
    case shop
    case discover
    case bookmark
    case cart
    case profile
}

final class BaseTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.unselectedItemTintColor = .black
        tabBar.itemPositioning = .centered
        setupViewControllers()
        DependencyContainer.shared.userDefaultsManager.save(key: .userLoggedIn, value: true)
    }
    
    private func setupViewControllers() {
        let shopVC = wrapViewController(child: ShopBuilder().build(), image: .shop)
        let discoverVC = wrapViewController(child: DiscoverBuilder().build(), image: .discover)
        let bookmarkVC = wrapViewController(child: BookmarkBuilder().build(), image: .bookmark)
        let cartVC = wrapViewController(child: CartBuilder().build(), image: .cart)
        let profileVC = wrapViewController(child: ProfileBuilder().build(), image: .user)
        
        tabBar.tintColor = .purple100
        tabBar.backgroundColor = .white
        setViewControllers([shopVC, discoverVC, bookmarkVC, cartVC, profileVC], animated: true)
    }
    
    private func wrapViewController(child: UIViewController, image: UIImage?) -> UIViewController {
        child.tabBarItem.image = image
        return child
    }
}
