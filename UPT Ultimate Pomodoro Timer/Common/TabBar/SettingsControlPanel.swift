//
//  SettingsControlPanel.swift
//  UPT Ultimate Pomodoro Timer
//
//  Created by  user on 12.10.2023.
//

import UIKit
import SnapKit

final class SettingsControlPanel: BaseControlPanel {
    
    // MARK: - Private Properties
    
    private lazy var saveButton = makeSaveButton()
    
    // MARK: - Override Methods

    override func configureUI() {
        backgroundColor = .clear
        addSubview(saveButton)
    }
    
    override func setConstraint() {
        let indent = NumericConstants.edgesIndentation
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(indent)
            make.left.equalTo(self.snp.left).offset(indent)
            make.right.equalTo(self.snp.right).inset(indent)
            make.bottom.equalTo(self.snp.bottom).inset(indent)
        }
    }
    
    override func setupTargetButton() {
        saveButton.addTarget(
            self,
            action: #selector(handleSaveButton(_:)),
            for: .touchUpInside
        )
    }
}

// MARK: - Factory Methods

private extension SettingsControlPanel {
    func makeSaveButton() -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = NumericConstants.cornerRadius
        if #available(iOS 13, *) {
            button.layer.cornerCurve = .continuous
        }
        button.setTitle("SAVE", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: 18,
            weight: .regular
        )
        button.backgroundColor = .clear
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

// MARK: - Objc Methods

private extension SettingsControlPanel {
    @objc
    func handleSaveButton(_ button: UIButton) {
        print("Debug Pressed save")
    }
}

// MARK: - Constants

private extension SettingsControlPanel {
    enum NumericConstants {
        static let cornerRadius: CGFloat = 20
        static let edgesIndentation: CGFloat = 5
    }
}
