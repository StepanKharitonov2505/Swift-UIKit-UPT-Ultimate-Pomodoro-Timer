//
//  TimerScreenView.swift
//  UPT Ultimate Pomodoro Timer
//
//  Created by  user on 11.10.2023.
//

import UIKit
import SnapKit

class TimerScreenView: UIView {
    
    private lazy var titleLabel = makeTitleLabel()
    private lazy var timerVisualizeView = makeTimerVisualizeView()

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
        addSubview(timerVisualizeView)
    }
    
    func setConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(70)
            make.left.equalTo(self.snp.left).offset(25)
            make.right.equalTo(self.snp.right).inset(25)
        }
        
        timerVisualizeView.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(25)
            make.right.equalTo(self.snp.right).inset(25)
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.bottom.equalTo(self.snp.bottom).inset(210)
        }
    }
}

// MARK: - Factory Methods

private extension TimerScreenView {
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        label.text = "WORKING TIMER"
        label.numberOfLines = 2
        label.textColor = UIColor.rgb(234, 244, 255)
        return label
    }
    
    func makeTimerVisualizeView() -> UIView {
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
