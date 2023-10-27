import UIKit
import SnapKit

final class SettingsScreenView: UIView {
    
    // MARK: - Public Properties
    
    public lazy var saveButton = makeSaveButton()
    
    // MARK: - Private Properties
    
    private lazy var titleLabel = makeTitleLabel()
    private lazy var settingsTable = makeSettingsTable()
    
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
        addSubview(settingsTable)
        addSubview(saveButton)
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
        
        saveButton.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width).multipliedBy(NumericConstants.widthFactor)
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).inset(100)
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
    
    func makeSettingsTable() -> UIView {
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
        button.backgroundColor = .white
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

// MARK: - Constants

private extension SettingsScreenView {
    enum NumericConstants {
        static let cornerRadius: CGFloat = 15
        static let edgesIndentation: CGFloat = 5
        static let widthFactor: Double = 0.7
    }
    
    enum StrokeConstants {
        static let screenTitle: String = "SETTINGS"
        static let saveButtonTitle: String = "SAVE"
        
        enum FontsNames {
            static let titleFontName: String = "Montserrat-Medium"
            static let timerNumberFontName: String = "Montserrat-ExtraLight"
        }
    }
}
