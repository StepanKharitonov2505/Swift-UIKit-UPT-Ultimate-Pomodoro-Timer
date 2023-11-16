import UIKit
import SnapKit

final class SettingsScreenView: UIView {
    
    // MARK: - Public Properties
    
    public lazy var saveButton = makeSaveButton()
    public lazy var workingPeriodTimePicker = makeTimePickerCollection()
    public lazy var shortBreakTimePicker = makeTimePickerCollection()
    public lazy var longBreakTimePicker = makeTimePickerCollection()
    
    // MARK: - Private Properties
    
    private lazy var titleLabel = makeTitleLabel()
    
    private lazy var subtitleWorkingPeriod = makeSubtitleLabel(text: StrokeConstants.textWorkingPeriodTimeLabel)
    private lazy var subtitleShortBreak = makeSubtitleLabel(text: StrokeConstants.textShortBreakTimeLabel)
    private lazy var subtitleLongBreak = makeSubtitleLabel(text: StrokeConstants.textLongBreakTimeLabel)
    
    private lazy var minuteTextWorkingPeriod = makeSubtitleLabel(
        text: StrokeConstants.textMinuteTimeLabel,
        isMinuteText: true
    )
    private lazy var minuteTextShortBreak = makeSubtitleLabel(
        text: StrokeConstants.textMinuteTimeLabel,
        isMinuteText: true
    )
    private lazy var minuteTextLongBreak = makeSubtitleLabel(
        text: StrokeConstants.textMinuteTimeLabel,
        isMinuteText: true
    )
    
    private lazy var backgroundLogoView = makeBackgroundLogoView()
    private lazy var stackLogoInfo = makeHorizontalLogoStack()
    private lazy var designDevSkLogo = makeLogoImageView(.designDev_SK)
    private lazy var contactsLabel = makeLogoContacts(text: StrokeConstants.contactsText)
    
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

private extension SettingsScreenView {
    func configureUI() {
        backgroundColor = ColorSet.FoundationColors.mainBackgroundColor
        addSubview(titleLabel)
        addSubview(subtitleWorkingPeriod)
        addSubview(subtitleShortBreak)
        addSubview(subtitleLongBreak)
        addSubview(minuteTextWorkingPeriod)
        addSubview(minuteTextShortBreak)
        addSubview(minuteTextLongBreak)
        addSubview(workingPeriodTimePicker)
        addSubview(shortBreakTimePicker)
        addSubview(longBreakTimePicker)
        addSubview(saveButton)
        
        addSubview(backgroundLogoView)
        backgroundLogoView.addSubview(stackLogoInfo)
        stackLogoInfo.addArrangedSubview(designDevSkLogo)
        stackLogoInfo.addArrangedSubview(contactsLabel)
    }
    
    func setConstraint() {
        let offsetSubtitle = NumericConstants.offsetSubtitleText
        let topOffsetSubtitle = CheckSmallScreen.isSmallScreen() ? NumericConstants.topOffsetSubtitleTextSmallScreen : NumericConstants.topOffsetSubtitleText
        let saveButtonBottomInset = CheckSmallScreen.isSmallScreen() ? 75 : 90
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(15)
            make.left.equalTo(self.snp.left).offset(26)
            make.right.equalTo(self.snp.right).inset(26)
        }
        
        subtitleWorkingPeriod.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(topOffsetSubtitle)
            make.left.equalTo(self.snp.left).offset(offsetSubtitle)
        }
        
        minuteTextWorkingPeriod.snp.makeConstraints { make in
            make.centerY.equalTo(subtitleWorkingPeriod.snp.centerY)
            make.height.equalTo(subtitleWorkingPeriod.snp.height)
            make.right.equalTo(self.snp.right).inset(offsetSubtitle)
        }
        
        workingPeriodTimePicker.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.top.equalTo(subtitleWorkingPeriod.snp.bottom).offset(15)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
        }
        
        subtitleShortBreak.snp.makeConstraints { make in
            make.top.equalTo(workingPeriodTimePicker.snp.bottom).offset(topOffsetSubtitle)
            make.left.equalTo(self.snp.left).offset(offsetSubtitle)
        }
        
        minuteTextShortBreak.snp.makeConstraints { make in
            make.centerY.equalTo(subtitleShortBreak.snp.centerY)
            make.height.equalTo(subtitleShortBreak.snp.height)
            make.right.equalTo(self.snp.right).inset(offsetSubtitle)
        }
        
        shortBreakTimePicker.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.top.equalTo(subtitleShortBreak.snp.bottom).offset(15)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
        }
        
        subtitleLongBreak.snp.makeConstraints { make in
            make.top.equalTo(shortBreakTimePicker.snp.bottom).offset(topOffsetSubtitle)
            make.left.equalTo(self.snp.left).offset(offsetSubtitle)
        }
        
        minuteTextLongBreak.snp.makeConstraints { make in
            make.centerY.equalTo(subtitleLongBreak.snp.centerY)
            make.height.equalTo(subtitleLongBreak.snp.height)
            make.right.equalTo(self.snp.right).inset(offsetSubtitle)
        }
        
        longBreakTimePicker.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.top.equalTo(subtitleLongBreak.snp.bottom).offset(15)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
        }
        
        saveButton.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width).multipliedBy(NumericConstants.widthFactor)
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).inset(saveButtonBottomInset)
            make.height.equalTo(55)
        }
        
        backgroundLogoView.snp.makeConstraints { make in
            make.top.equalTo(longBreakTimePicker.snp.bottom).offset(10)
            make.bottom.equalTo(saveButton.snp.top).offset(-10)
            make.left.equalTo(self.snp.left).offset(28)
            make.right.equalTo(self.snp.right).inset(28)
        }
        
        stackLogoInfo.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.center.equalTo(backgroundLogoView.snp.center)        }
        
        designDevSkLogo.snp.makeConstraints { make in
            make.height.width.equalTo(60)
        }
    }
    
    // MARK: - Test Methods
    
    func addTargetPlayButton() {
        saveButton.addTarget(
            self,
            action: #selector(handlePlayButton(_:)),
            for: .touchUpInside
        )
    }
    
    @objc
    func handlePlayButton(_ button: UIButton) {
        //UIApplication.shared.open(URL(string: "https://t.me/Thinking_stone")!)
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
} 

// MARK: - Factory Methods

private extension SettingsScreenView {
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(
            name: StrokeConstants.FontsNames.titleFontName,
            size: NumericConstants.sizeFontTitle
        )
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSMutableAttributedString(
            string: StrokeConstants.screenTitle,
            attributes: [NSAttributedString.Key.kern: 4.5]
        )
        label.textColor = ColorSet.FoundationColors.titleColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func makeSubtitleLabel(
        text: String,
        isMinuteText: Bool = false
    ) -> UILabel {
        let label = UILabel()
        let fontSize: CGFloat = isMinuteText ? NumericConstants.sizeFontMinuteText : NumericConstants.sizeFontSubtitle
        let textColor: UIColor = isMinuteText ? ColorSet.FoundationColors.titleColor.withAlphaComponent(0.5) : ColorSet.FoundationColors.titleColor
        label.font = UIFont(
            name: StrokeConstants.FontsNames.subtitleFontName,
            size: fontSize
        )
        label.text = text
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.textColor = textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func makeSaveButton() -> InteractiveButton {
        let button = InteractiveButton()
        button.layer.cornerRadius = NumericConstants.cornerRadius
        if #available(iOS 13, *) {
            button.layer.cornerCurve = .continuous
        }
        button.setTitle(
            StrokeConstants.saveButtonTitle,
            for: .normal
        )
        button.setTitleColor(
            .black,
            for: .normal
        )
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: 18,
            weight: .regular
        )
        button.backgroundColor = ColorSet.FoundationColors.actionButtonsColor
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func makeTimePickerCollection() -> UICollectionView {
        let collection = UICollectionView.init(
            frame: CGRect(origin: .zero, size: CGSize(
                width: self.bounds.width,
                height: 60
            )),
            collectionViewLayout: TimePickerSelectorLayout()
        )
        collection.decelerationRate = .normal
        collection.isScrollEnabled = true
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }
    
    func makeLogoImageView(_ type: LogoType) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        switch type {
        case .designDev_SK:
            imageView.image = UIImage(named: StrokeConstants.LogoNames.designDev_SK)
        case .design_SK:
            imageView.image = UIImage(named: StrokeConstants.LogoNames.design_SK)
        case .dev_SK:
            imageView.image = UIImage(named: StrokeConstants.LogoNames.dev_SK)
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    func makeBackgroundLogoView() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func makeHorizontalLogoStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 25
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
    
    func makeLogoContacts(text: String) -> UILabel {
        let label = UILabel()
        let fontSize: CGFloat = NumericConstants.sizeFontMinuteText
        let textColor: UIColor = ColorSet.FoundationColors.titleColor.withAlphaComponent(0.5)
        label.font = UIFont(
            name: StrokeConstants.FontsNames.subtitleFontName,
            size: fontSize
        )
        label.text = text
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.textColor = textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

// MARK: - Constants

private extension SettingsScreenView {
    enum NumericConstants {
        static let cornerRadius: CGFloat = 20
        static let widthFactor: Double = 0.7
        static let sizeFontSubtitle: CGFloat = 20
        static let sizeFontTitle: CGFloat = 45
        static let sizeFontMinuteText: CGFloat = 15
        static let leftOffsetMinuteText: CGFloat = 10
        static let offsetSubtitleText: CGFloat = 28
        
        static let topOffsetSubtitleText: CGFloat = 25
        static let topOffsetSubtitleTextSmallScreen: CGFloat = 10
    }
    
    enum StrokeConstants {
        static let screenTitle: String = "SETTINGS"
        static let saveButtonTitle: String = "SAVE"
        static let textWorkingPeriodTimeLabel: String = "Working period time"
        static let textShortBreakTimeLabel: String = "Short break time"
        static let textLongBreakTimeLabel: String = "Long break time"
        static let textMinuteTimeLabel: String = "minute"
        static let contactsText: String = "You logo can be here!\nWrite to telegram:\n@Thinking_stone"
        
        enum FontsNames {
            static let titleFontName: String = "Montserrat-Medium"
            static let timerNumberFontName: String = "Montserrat-ExtraLight"
            static let subtitleFontName: String = "Montserrat-Light"
        }
        
        enum LogoNames {
            static let designDev_SK: String = "DesignDevLogoSK"
            static let design_SK: String = "DesignLogoSK"
            static let dev_SK: String = "DevLogoSK"
        }
    }
}
