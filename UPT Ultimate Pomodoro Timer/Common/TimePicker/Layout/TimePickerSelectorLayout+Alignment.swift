import UIKit
/// НЕ ИСПОЛЬЗУЕТСЯ
/// НУЖНО ДЛЯ СМЕЩЕНИЯ КОНТЕНТА ЯЧЕЙКИ
extension TimePickerSelectorLayout {
    
    func centerAlignedFrame(
        for element: UICollectionViewLayoutAttributes,
        scale: CGFloat
    ) -> CGRect {
        
        let hOffset = horizontalOffset(
            for: element,
            scale: scale
        )
        let vOffset = verticalOffset(
            for: element,
            scale: scale
        )
        
        return element
            .frame
            .offsetBy(
                dx: +hOffset - spaceBetweenHalves / 2,
                dy: vOffset
            )
    }
    
    private func horizontalOffset(
        for element: UICollectionViewLayoutAttributes,
        scale: CGFloat
    ) -> CGFloat {
        let collectionWidth = collectionView!.bounds.width
        let scaledElementWidth = element.frame.width * scale
        let hOffset = (collectionWidth - scaledElementWidth) / 2
        
        return hOffset
    }
    
    private func verticalOffset(
        for element: UICollectionViewLayoutAttributes,
        scale: CGFloat
    ) -> CGFloat {
        let offsetFromCenter    = offsetFromScreenCenter(element.frame)
        let vOffset: CGFloat    = TimePickerSelectorLayout.verticalOffset(
            offsetFromCenter: offsetFromCenter,
            scale: scale)
        
        return vOffset
    }
    
    static func verticalOffset(
        offsetFromCenter: CGFloat,
        scale: CGFloat
    ) -> CGFloat {
        return -offsetFromCenter / 4 * scale
    }
}
