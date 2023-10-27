import UIKit

class InteractiveButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                UIView.animate(withDuration: 0.2,
                               delay: 0,
                               options: [
                                .allowUserInteraction,
                                .beginFromCurrentState
                               ]
                ) {
                    self.transform = CGAffineTransform(scaleX: 0.99, y: 0.99)
                    self.alpha = 0.75
                }
            } else {
                UIView.animate(withDuration: 0.2,
                               delay: 0,
                               options: [
                                .allowUserInteraction,
                                .beginFromCurrentState
                               ]
                ) {
                    self.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self.alpha = 1
                }
            }
        }
    }
}
