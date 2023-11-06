import UIKit

extension TimePickerSelectorLayout {
    
    func scale(for element: Int, criticalOffset: CGFloat) -> CGFloat {
        let frame = cache.defaultCellFrame(atElements: element)
        let scale = self.scale(for: frame, criticalOffset: criticalOffset)
        return scale.normalized
    }
    
    func scale(for frame: CGRect, criticalOffset: CGFloat) -> CGFloat {
        let criticalOffset = criticalOffset // 200 pt
        let centerOffset = offsetFromScreenCenter(frame)
        let relativeOffset = centerOffset / criticalOffset
        return relativeOffset
    }
    
    func offsetFromScreenCenter(_ frame: CGRect) -> CGFloat {
        return frame.midX - collectionView!.screenCenterXOffset()
    }
}

extension CGFloat {
    var normalized: CGFloat {
        return CGFloat.minimum(1, CGFloat.maximum(-1, self))
    }
}
