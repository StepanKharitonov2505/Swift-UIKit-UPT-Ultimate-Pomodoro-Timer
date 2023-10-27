import UIKit

class BaseControlPanel: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraint()
        setupTargetButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
        setConstraint()
        setupTargetButton()
    }

    func configureUI() {}
    func setConstraint() {}
    func setupTargetButton() {}
}
