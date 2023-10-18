//
//  SettingsViewController.swift
//  UPT Ultimate Pomodoro Timer
//
//  Created by  user on 11.10.2023.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    override func loadView() {
        self.view = SettingsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Private methods

private extension SettingsViewController {
    
}

// MARK: - Objc Methods

private extension SettingsViewController {
    @objc private func handleButton(_ button: UIButton) {
        print("Debug Pressed settings button")
    }
}

