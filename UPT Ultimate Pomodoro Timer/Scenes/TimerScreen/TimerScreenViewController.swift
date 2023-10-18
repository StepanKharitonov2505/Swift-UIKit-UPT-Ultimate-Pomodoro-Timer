//
//  ViewController.swift
//  UPT Ultimate Pomodoro Timer
//
//  Created by  user on 11.10.2023.
//

import UIKit
import SnapKit

class TimerScreenViewController: UIViewController {
    
    override func loadView() {
        self.view = TimerScreenView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Private Methods

private extension TimerScreenViewController {

}

// MARK: - Objc Methods

private extension TimerScreenViewController {
    @objc func handleButton(_ button: UIButton) {
        print("Debug Pressed timer screen button")
    }
}

