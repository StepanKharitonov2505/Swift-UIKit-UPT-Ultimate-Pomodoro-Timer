import UIKit

extension UIScrollView {
    func screenCenterYOffset(for offset: CGPoint? = nil) -> CGFloat {
        let offsetY = offset?.y ?? contentOffset.y
        let contentOffsetY = offsetY + bounds.height / 2
        return contentOffsetY
    }
    
    func screenCenterXOffset(for offset: CGPoint? = nil) -> CGFloat {
        let offsetX = offset?.x ?? contentOffset.x
        let contentOffsetX = offsetX + bounds.width / 2
        return contentOffsetX
    }
}
