import UIKit

final class TableLayoutCache {
    
    var contentSize: CGSize {
        return CGSize(width: defaultFrames.last?.maxX ?? 0,
                      height: collectionHeight
        )
    }
    
    static var initial: TableLayoutCache {
        return TableLayoutCache(collectionHeight: 0)
    }
    
    private let collectionHeight: CGFloat
    private var defaultFrames = [CGRect]()
    
    init(collectionHeight: CGFloat) {
        self.collectionHeight = collectionHeight
    }
    
    // MARK: - Calculation
    func recalculateDefaultFrames(numberOfItems: Int) {
        defaultFrames = (0..<numberOfItems).map {
            defaultCellFrame(atElements: $0)
        }
    }
    
    func defaultCellFrame(atElements elements: Int) -> CGRect {
        let x = Constants.itemSize * CGFloat(elements)
        let defaultFrame = CGRect(
            x: x,
            y: 0,
            width: Constants.itemSize,
            height: Constants.itemSize
        )

        return defaultFrame
    }
    
    
    // MARK: - Access
    func visibleRows(in frame: CGRect) -> [Int] {
        return defaultFrames
            .enumerated() // Index to frame relation
            .filter { $0.element.intersects(frame)} // Filter by frame
            .map { $0.offset } // Return indexes
    }
}

// MARK: - Constants

private extension TableLayoutCache {
    enum Constants {
        static let itemSize: CGFloat = 50
    }
}
