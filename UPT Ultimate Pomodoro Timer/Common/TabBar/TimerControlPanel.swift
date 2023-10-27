import UIKit
import SnapKit

final class TimerControlPanel: BaseControlPanel {
    
    // MARK: - Private Properties
    
    private lazy var playButton = makePlayButton()
    private lazy var nextButton = makeNextButton()
    private lazy var refreshButton = makeRefreshButton()
    private lazy var firstSeparator = makeSeparator()
    private lazy var secondSeparator = makeSeparator()
    
    // MARK: - Override SuperMethods

    override func configureUI() {
        backgroundColor = .clear
        addSubview(playButton)
        addSubview(nextButton)
        addSubview(refreshButton)
        addSubview(firstSeparator)
        addSubview(secondSeparator)
    }
    
    override func setConstraint() {
        let indent = NumericConstants.edgesIndentation
        
        playButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(indent)
            make.left.equalTo(self.snp.left).offset(indent)
            make.bottom.equalTo(self.snp.bottom).inset(indent)
            make.width.equalTo(self.snp.width).dividedBy(2).inset(indent + 1)
        }
        
        firstSeparator.snp.makeConstraints { make in
            make.width.equalTo(NumericConstants.separatorWidth)
            make.top.equalTo(self.snp.top).offset(indent)
            make.bottom.equalTo(self.snp.bottom).inset(indent)
            make.centerX.equalTo(self.snp.centerX)
        }

        nextButton.snp.makeConstraints { make in
            make.left.equalTo(firstSeparator.snp.right).offset(indent)
            make.top.equalTo(self.snp.top).offset(indent)
            make.bottom.equalTo(self.snp.bottom).inset(indent)
            make.width.equalTo(self.snp.width).dividedBy(4).inset(indent + 1)
        }

        secondSeparator.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX).multipliedBy(1.5)
            make.width.equalTo(NumericConstants.separatorWidth)
            make.top.equalTo(self.snp.top).offset(indent)
            make.bottom.equalTo(self.snp.bottom).inset(indent)
        }

        refreshButton.snp.makeConstraints { make in
            make.left.equalTo(secondSeparator.snp.right).offset(indent)
            make.top.equalTo(self.snp.top).offset(indent)
            make.bottom.equalTo(self.snp.bottom).inset(indent)
            make.right.equalTo(self.snp.right).inset(indent)
        }
    }
    
    override func setupTargetButton() {
        playButton.addTarget(
            self,
            action: #selector(handlePlayButton(_:)),
            for: .touchUpInside
        )
        
        nextButton.addTarget(
            self,
            action: #selector(handleNextButton(_:)),
            for: .touchUpInside
        )
        
        refreshButton.addTarget(
            self,
            action: #selector(handleRefreshButton(_:)),
            for: .touchUpInside
        )
    }
}

// MARK: - Factory Methods

private extension TimerControlPanel {
    func makePlayButton() -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = NumericConstants.cornerRadius
        if #available(iOS 13, *) {
            button.layer.cornerCurve = .continuous
        }
        button.setImage(
            UIImage(systemName: "play"),
            for: .normal
        )
        button.backgroundColor = .clear
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func makeNextButton() -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = NumericConstants.cornerRadius
        if #available(iOS 13, *) {
            button.layer.cornerCurve = .continuous
        }
        button.setImage(
            UIImage(systemName: "arrowshape.right"),
            for: .normal
        )
        button.backgroundColor = .clear
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func makeRefreshButton() -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = NumericConstants.cornerRadius
        if #available(iOS 13, *) {
            button.layer.cornerCurve = .continuous
        }
        button.setImage(
            UIImage(systemName: "repeat.circle"),
            for: .normal
        )
        button.backgroundColor = .clear
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func makeSeparator() -> UIView {
        let view  = UIView()
        view.layer.cornerRadius = 1
        if #available(iOS 13, *) {
            view.layer.cornerCurve = .continuous
        }
        view.backgroundColor = ColorSet
            .TabBarColors
            .ControlPanelColors
            .controlPanelSeparatorColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

// MARK: - Objc Methods

private extension TimerControlPanel {
    @objc
    func handlePlayButton(_ button: UIButton) {
        print("Debug Pressed play")
    }
    
    @objc
    func handleNextButton(_ button: UIButton) {
        print("Debug Pressed next")
    }
    
    @objc
    func handleRefreshButton(_ button: UIButton) {
        print("Debug Pressed refresh")
    }
}

// MARK: - Constants

private extension TimerControlPanel {
    enum NumericConstants {
        static let cornerRadius: CGFloat = 20
        static let edgesIndentation: CGFloat = 5
        static let separatorWidth: CGFloat = 2
    }
}
