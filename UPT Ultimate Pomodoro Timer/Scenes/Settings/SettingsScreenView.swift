import UIKit
import SnapKit

final class SettingsScreenView: UIView {
    
    // MARK: - Public Properties
    
    public lazy var saveButton = makeSaveButton()
    public lazy var timePickerCollectionView = makeTimePickerCollection()
    
    // MARK: - Private Properties
    
    private lazy var titleLabel = makeTitleLabel()
    private lazy var subtitleWorkingPeriod = makeSubtitleLabel(text: "Working period time")
    
    // MARK: - Init
    
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
}

// MARK: - Private Methods

private extension SettingsScreenView {
    func configureUI() {
        backgroundColor = ColorSet.FoundationColors.mainBackgroundColor
        addSubview(titleLabel)
        addSubview(subtitleWorkingPeriod)
        addSubview(timePickerCollectionView)
        addSubview(saveButton)
    }
    
    func setConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(15)
            make.left.equalTo(self.snp.left).offset(26)
            make.right.equalTo(self.snp.right).inset(26)
        }
        
        subtitleWorkingPeriod.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.equalTo(self.snp.left).offset(28)
        }
        
        timePickerCollectionView.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.top.equalTo(subtitleWorkingPeriod.snp.bottom).offset(10)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
        }
        
        saveButton.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width).multipliedBy(NumericConstants.widthFactor)
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).inset(95)
            make.height.equalTo(60)
        }
    }
} 

// MARK: - Factory Methods

private extension SettingsScreenView {
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(
            name: StrokeConstants.FontsNames.titleFontName,
            size: 45
        )
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSMutableAttributedString(
            string: StrokeConstants.screenTitle,
            attributes: [NSAttributedString.Key.kern: 4.5]
        )
        label.textColor = UIColor.rgb(234, 244, 255)
        return label
    }
    
    func makeSubtitleLabel(text: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont(
            name: StrokeConstants.FontsNames.subtitleFontName,
            size: 20
        )
        label.text = text
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor.rgb(234, 244, 255)
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
        collection.decelerationRate = .fast
        collection.isScrollEnabled = true
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }
}

// MARK: - Constants

private extension SettingsScreenView {
    enum NumericConstants {
        static let cornerRadius: CGFloat = 20
        static let edgesIndentation: CGFloat = 5
        static let widthFactor: Double = 0.7
    }
    
    enum StrokeConstants {
        static let screenTitle: String = "SETTINGS"
        static let saveButtonTitle: String = "SAVE"
        
        enum FontsNames {
            static let titleFontName: String = "Montserrat-Medium"
            static let timerNumberFontName: String = "Montserrat-ExtraLight"
            static let subtitleFontName: String = "Montserrat-Light"
        }
    }
}
