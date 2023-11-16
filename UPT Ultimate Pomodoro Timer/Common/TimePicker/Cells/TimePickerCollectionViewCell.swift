import UIKit
import SnapKit

class TimePickerCollectionViewCell: UICollectionViewCell {
    
    var timePickerElement: TimePickerElementViewModel? {
        didSet {
            timeLabel.text = "\(timePickerElement?.timeSize ?? 0)" 
        }
    }
    
    var selectionType: TimePickerCellSelectedType = .unselect {
        didSet {
            setNeedsLayout()
        }
    }
    
    // MARK: - Private Properties
    
    private lazy var timeLabel = makeTimeLabel()
    private lazy var substrateTimeLabel = makeSubstrate()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        substrateTimeLabel.layer.borderColor = UIColor.clear.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if selectionType == .select {
            UIView.animate(withDuration: 0.25) { [weak self] in
                self?.substrateTimeLabel.layer.borderColor = UIColor.rgb(246, 249, 228).cgColor
            }
        } else {
            substrateTimeLabel.layer.borderColor = UIColor.clear.cgColor
        }
    }
}

// MARK: - Private Methods

private extension TimePickerCollectionViewCell {
    func configureUI() {
        contentView.backgroundColor = .clear
        contentView.addSubview(substrateTimeLabel)
        substrateTimeLabel.addSubview(timeLabel)
        setConstraint()
    }
    
    func setConstraint() {
        substrateTimeLabel.snp.makeConstraints { make in
            make.center.equalTo(contentView.snp.center)
            make.height.equalTo(50)
            make.left.right.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints { make in
            make.center.equalTo(contentView.snp.center)
        }
    }
}

// MARK: - Factory Methods

private extension TimePickerCollectionViewCell {
    func makeTimeLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(
            name: StrokeConstants.FontsNames.timerNumberFontName,
            size: 20
        )
        label.textColor = UIColor.rgb(234, 244, 255)
        return label
    }
    
    func makeSubstrate() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = NumericConstants.cornerRadius
        view.backgroundColor = UIColor.rgb(40, 47, 85)
        if #available(iOS 13, *) {
            view.layer.cornerCurve = .continuous
        }
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.clear.cgColor
        return view
    }
}

// MARK: - Constants

private extension TimePickerCollectionViewCell {
    enum NumericConstants {
        static let cornerRadius: CGFloat = 10
    }
    
    enum StrokeConstants {
        enum FontsNames {
            static let timerNumberFontName: String = "Montserrat-Light"
        }
    }
}
