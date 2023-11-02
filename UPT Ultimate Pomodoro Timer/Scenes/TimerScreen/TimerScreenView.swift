import UIKit
import SnapKit

final class TimerScreenView: UIView {
    
    // MARK: - Public Properties
    
    public lazy var playPauseButton = makeButton(.play)
    public lazy var nextButton = makeButton(.next)
    public lazy var refreshButton = makeButton(.refresh)
    
    // MARK: - Private Properties
    
    private lazy var titleLabel = makeTitleLabel()
    private lazy var timerVisualizeView = makeTimerVisualizeView()
    private lazy var buttonContainer = makeHorizontalStack()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraint()
        addTargetPlayButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
        setConstraint()
        addTargetPlayButton()
    }
}

// MARK: - Private Methods

private extension TimerScreenView {
    func configureUI() {
        backgroundColor = ColorSet.FoundationColors.mainBackgroundColor
        addSubview(titleLabel)
        addSubview(timerVisualizeView)
        addSubview(buttonContainer)
        fillingButtonContainer()
    }
    
    func setConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(15)
            make.left.equalTo(self.snp.left).offset(25)
            make.right.equalTo(self.snp.right).inset(25)
        }
        
        timerVisualizeView.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(25)
            make.right.equalTo(self.snp.right).inset(25)
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.bottom.equalTo(self.snp.bottom).inset(180)
        }
        
        buttonContainer.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(self.snp.width).multipliedBy(NumericConstants.widthFactor)
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).inset(95)
        }
        
        playPauseButton.snp.makeConstraints { make in
            make.width.equalTo(buttonContainer.snp.width).multipliedBy(0.5)
        }
        
        nextButton.snp.makeConstraints { make in
            make.width.equalTo(refreshButton.snp.width)
        }
    }
    
    func fillingButtonContainer() {
        let _ = [
            playPauseButton,
            nextButton,
            refreshButton,
        ].forEach {
            buttonContainer.addArrangedSubview($0)
        }
    }
    
    // MARK: - Test Methods
    
    func addTargetPlayButton() {
        playPauseButton.addTarget(
            self,
            action: #selector(handlePlayButton(_:)),
            for: .touchUpInside
        )
    }
    
    @objc
    func handlePlayButton(_ button: UIButton) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

// MARK: - Factory Methods

private extension TimerScreenView {
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(
            name: StrokeConstants.FontsNames.titleFontName,
            size: 45
        )
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSMutableAttributedString(
            string: StrokeConstants.screenTitle,
            attributes: [NSAttributedString.Key.kern: 4.5]
        )
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
        view.layer.borderColor = ColorSet
            .TabBarColors
            .ControlPanelColors
            .controlPanelSeparatorColor
            .cgColor
        view.layer.borderWidth = 1
        return view
    }
    
    func makeButton(_ type: ButtonType) -> InteractiveButton {
        let button = InteractiveButton()
        let imageName: String
        button.layer.cornerRadius = NumericConstants.cornerRadius
        if #available(iOS 13, *) {
            button.layer.cornerCurve = .continuous
        }
        switch type {
        case .play:
            imageName = StrokeConstants.ImageNames.playButtonImageName
        case .next:
            imageName = StrokeConstants.ImageNames.nextButtonImageName
        case .refresh:
            imageName = StrokeConstants.ImageNames.refreshButtonImageName
        }
        button.setImage(
            UIImage(systemName: imageName),
            for: .normal
        )
        button.backgroundColor = ColorSet.FoundationColors.actionButtonsColor
//        button.backgroundColor = .clear
//        button.layer.borderWidth = 1.5
//        button.layer.borderColor = ColorSet.FoundationColors.actionButtonsColor.cgColor
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func makeHorizontalStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }
}

// MARK: - Constants & Enums

private extension TimerScreenView {
    enum ButtonType {
        case play
        case next
        case refresh
    }
    
    enum NumericConstants {
        static let cornerRadius: CGFloat = 20
        static let widthFactor: Double = 0.7
    }
    
    enum StrokeConstants {
        static let screenTitle: String = "WORKING TIMER"
        
        enum ImageNames {
            static let playButtonImageName: String = "play"
            static let pauseButtonImageName: String = ""
            static let nextButtonImageName: String = "arrowshape.right"
            static let refreshButtonImageName: String = "repeat.circle"
        }
        
        enum FontsNames {
            static let titleFontName: String = "Montserrat-Medium"
            static let timerNumberFontName: String = "Montserrat-ExtraLight"
        }
    }
}
