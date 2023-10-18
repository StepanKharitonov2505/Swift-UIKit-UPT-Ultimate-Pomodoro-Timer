//
//  UPTTabBarController.swift
//  UPT Ultimate Pomodoro Timer
//
//  Created by  user on 12.10.2023.
//

import UIKit
import SnapKit

final class UPTTabBarController: UITabBarController {
    
    // MARK: - Private Properties
    
    private var customTabBar: UPTTabBar!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTabBar()
        delegate = self
    }
}

// MARK: - Private Methods

private extension UPTTabBarController {
    
    func loadTabBar() {
        let tabItems: [UPTTabItem] = [.timerScreen, .settingsScreen]
        self.setupCustomTabBar(tabItems) { (controllers) in
            self.viewControllers = controllers
        }
        
        self.selectedIndex = 0
    }
    
    func setupCustomTabBar(
        _ items: [UPTTabItem],
        completion: @escaping ([UIViewController]
        ) -> Void) {
        let frame = CGRect(
            x: tabBar.frame.origin.x,
            y: tabBar.frame.origin.x,
            width: tabBar.frame.width,
            height: NumericConstants.tabBarHeight
        )
        
        var controllers = [UIViewController]()
        
        tabBar.isHidden = true
        
        self.customTabBar = UPTTabBar(
            menuItems: items,
            frame: frame
        )
        self.customTabBar.translatesAutoresizingMaskIntoConstraints = false
        self.customTabBar.itemTapped = self.changeTab
        self.view.addSubview(customTabBar)

        let leftRightOffset = self.tabBar.frame.width * NumericConstants.tabBarLateralPercentageIndentation
        
        self.customTabBar.snp.makeConstraints { make in
            make.left.equalTo(tabBar.snp.left).offset(leftRightOffset)
            make.right.equalTo(tabBar.snp.right).inset(leftRightOffset)
            make.height.equalTo(NumericConstants.tabBarHeight)
            make.bottom.equalTo(tabBar.snp.bottom).inset(NumericConstants.tabBarBottomInset)
        }
        
        for i in 0 ..< items.count {
            controllers.append(items[i].viewController)
        }
        
        self.view.layoutIfNeeded()
        completion(controllers)
    }
    
    func changeTab(tab: Int) {
        self.selectedIndex = tab
    }
}

// MARK: - TabBar Delegate

extension UPTTabBarController: UITabBarControllerDelegate {
    func tabBarController(
        _ tabBarController: UITabBarController,
        animationControllerForTransitionFrom fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return CustomTransition(viewControllers: tabBarController.viewControllers)
    }
}

// MARK: - Constants

private extension UPTTabBarController {
    enum NumericConstants {
        static let tabBarHeight: CGFloat = 80
        static let tabBarBottomInset: CGFloat = 25
        static let tabBarLateralPercentageIndentation: Double = 0.15
    }
}
