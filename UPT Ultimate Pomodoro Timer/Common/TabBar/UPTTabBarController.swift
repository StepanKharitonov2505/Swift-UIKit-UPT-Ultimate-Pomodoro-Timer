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
        let tabItems: [UPTTabItem] = [
            .timerScreen,
            .settingsScreen,
        ]
        self.setupCustomTabBar(tabItems) { (controllers) in
            self.viewControllers = controllers
        }
        
        self.selectedIndex = 0
    }
    
    func setupCustomTabBar(
        _ items: [UPTTabItem],
        completion: @escaping ([UIViewController]) -> Void
    ) {
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

        let tabBarBottomOffset = CheckSmallScreen.isSmallScreen() ? NumericConstants.tabBarBottomInsetSmallScreen : NumericConstants.tabBarBottomInset
        
        self.customTabBar.snp.makeConstraints { make in
            make.width.equalTo(tabBar.snp.width).multipliedBy(NumericConstants.tabBarWidthFactor)
            make.height.equalTo(NumericConstants.tabBarHeight)
            make.bottom.equalTo(tabBar.snp.bottom).inset(tabBarBottomOffset)
            make.centerX.equalTo(tabBar.snp.centerX)
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
        static let tabBarHeight: CGFloat = 55
        static let tabBarBottomInset: CGFloat = 25
        static let tabBarBottomInsetSmallScreen: CGFloat = 10
        static let tabBarWidthFactor: Double = 0.7
    }
}
