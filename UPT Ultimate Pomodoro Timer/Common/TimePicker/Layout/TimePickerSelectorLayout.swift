import UIKit

final class TimePickerSelectorLayout: TableLayout {
    
    // MARK: - Pizza index
    var currentTimeElementIndex: CGFloat = 0
    
    var currentTimeElementIndexInt: Int {
        return Int(currentTimeElementIndex)
    }
    
    var scrollingNumber: Double? {
        didSet {
            if oldValue != scrollingNumber && scrollingNumber != nil {
                if scrollingNumber?.truncatingRemainder(dividingBy: 2) != 0 && scrollingNumber! > 0 {
                    let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.impactOccurred(intensity: 0.8)
                }
            }
        }
    }
    
    private func updateCurrentTimeElementIndex() {
        currentTimeElementIndex = timeElementIndex(offset: collectionView!.contentOffset)
    }
    
    // MARK: - Private
    private let cellZLevel = 0
    
    func setupSizeAndInsets(timeElementSize: CGFloat) {
        itemSize = CGSize(
            width: timeElementSize,
            height: timeElementSize
        )
        setupInsets(timeElementSize: timeElementSize)
    }
    
    private func setupInsets(timeElementSize: CGFloat){
        let width = collectionView!.bounds.width
        let newInset = (width - timeElementSize) / 2
        collectionView!.contentInset = UIEdgeInsets(
            top: 0,
            left: newInset,
            bottom: 0,
            right: newInset
        )
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true // Invalidate on scroll
    }

    // MARK: - Scroll alignment
    override func targetContentOffset(
        forProposedContentOffset proposedContentOffset: CGPoint,
        withScrollingVelocity velocity: CGPoint
    ) -> CGPoint {
        let timeElementIndex = Int(self.timeElementIndex(offset: proposedContentOffset))
        let projectedOffset = contentOffset(for: timeElementIndex)
        
        let sameCell = timeElementIndex == currentTimeElementIndexInt
        if sameCell {
            animateBackwardScroll(to: timeElementIndex)
            return collectionView!.contentOffset // Stop scroll, we've animated manually
        }
//        let generator = UIImpactFeedbackGenerator(style: .light)
//        generator.impactOccurred()
        
        return projectedOffset
    }
    
    /// A bit of magic. Without that, high velocity moves cells backward very fast.
    /// We slow down the animation
    private func animateBackwardScroll(to timeElementIndex: Int) {
//        let generator = UIImpactFeedbackGenerator(style: .light)
//        generator.impactOccurred()
        let path = IndexPath(
            row: timeElementIndex,
            section: 0
        )
        
        collectionView?.scrollToItem(
            at: path,
            at: .centeredHorizontally,
            animated: true
        )
        
        // More magic here. Fix double-step animation.
        // You can't do it smoothly without that. Run loop, you know, ykhhh.
        DispatchQueue.main.async {
            self.collectionView?.scrollToItem(
                at: path,
                at: .centeredHorizontally,
                animated: true
            )
            
        }
    }
    
    // MARK: - Customize attributes
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let elements = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        
        updateCurrentTimeElementIndex()
        
        let cells = elements.filter { $0.representedElementCategory == .cell }
        updateCells(cells)
        
        return cells
    }

    static let criticalOffsetFromCenter: CGFloat = 200
    static private let scaleFactor: CGFloat = 0.6
    
    var spaceBetweenHalves: CGFloat = 4
}

// MARK: - Layout
extension TimePickerSelectorLayout {
    
    private func updateCells(_ cells: [UICollectionViewLayoutAttributes]) {
        for cell in cells {
            let normScale = scale(for: cell.indexPath.row)
            let scale = 1 - TimePickerSelectorLayout.scaleFactor * abs(normScale)
            
            cell.alpha = scale
            cell.transform = CGAffineTransform(
                scaleX: scale,
                y: scale
            )
            cell.zIndex = cellZLevel
        }
    }
}
