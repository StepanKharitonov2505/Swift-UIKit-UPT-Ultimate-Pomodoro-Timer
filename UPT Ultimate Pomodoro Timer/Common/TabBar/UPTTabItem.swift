//
//  UPTTabItem.swift
//  UPT Ultimate Pomodoro Timer
//
//  Created by  user on 12.10.2023.
//

import UIKit

enum UPTTabItem: String, CaseIterable {
    case timerScreen = "Timer"
    case settingsScreen = "Settings"
    
    var viewController: UIViewController {
        switch self {
        case .timerScreen:
            return TimerScreenViewController()
        case .settingsScreen:
            return SettingsViewController()
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .timerScreen:
            return UIImage(systemName: Constants.timerImageName)
        case .settingsScreen:
            return UIImage(systemName: Constants.settingsImageName)
        }
    }
    
    var displayTitle: String {
        return self.rawValue.capitalized(with: nil)
    }
    
    private enum Constants {
        static let timerImageName: String = "timer"
        static let settingsImageName: String = "gearshape"
    }
}
