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
        setupTabBarShadow()
        setupTabBarItemsPadding()
        DependencyContainer.shared.userDefaultsManager.save(key: .userLoggedIn, value: true)
    }
    
    private func setupTabBarShadow() {
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowOpacity = 0.04
        tabBar.layer.shadowRadius = 8
        tabBar.layer.shadowPath = UIBezierPath(rect: tabBar.bounds).cgPath
        tabBar.clipsToBounds = false
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
    
    private func setupTabBarItemsPadding() {
        if let items = tabBar.items {
            for item in items {
                item.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
            }
        }
    }
    
    private func wrapViewController(child: UIViewController, image: UIImage?) -> UIViewController {
        child.tabBarItem.image = image
        return child
    }
}
