import UIKit

extension TimePickerSelectorLayout {
    
    func scale(for element: Int) -> CGFloat {
        let frame = cache.defaultCellFrame(atElements: element)
        let scale = self.scale(for: frame)
        return scale.normalized
    }
    
    func scale(for frame: CGRect) -> CGFloat {
        let criticalOffset = TimePickerSelectorLayout.criticalOffsetFromCenter // 200 pt
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
