//
//  SettingsView.swift
//  UPT Ultimate Pomodoro Timer
//
//  Created by  user on 13.10.2023.
//

import UIKit
import SnapKit

class SettingsView: UIView {
    
    private lazy var titleLabel = makeTitleLabel()
    private lazy var settingsTable = makeSettingsTable()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
        setConstraint()
    }

    func configureUI() {
        backgroundColor = ColorSet.mainBackgroundColor
        addSubview(titleLabel)
        addSubview(settingsTable)
    }
    
    func setConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(70)
            make.left.equalTo(self.snp.left).offset(26)
            make.right.equalTo(self.snp.right).inset(26)
        }
        
        settingsTable.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(25)
            make.right.equalTo(self.snp.right).inset(25)
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.bottom.equalTo(self.snp.bottom).inset(210)
        }
    }
} 

// MARK: - Factory Methods

private extension SettingsView {
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        label.text = "SETTINGS"
        label.numberOfLines = 1
        label.textColor = UIColor.rgb(234, 244, 255)
        return label
    }
    
    func makeSettingsTable() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 20
        if #available(iOS 13, *) {
            view.layer.cornerCurve = .continuous
        }
        view.backgroundColor = .clear
        view.layer.borderColor = ColorSet.controlPanelSeparatorColor.cgColor
        view.layer.borderWidth = 1
        return view
    }
}
