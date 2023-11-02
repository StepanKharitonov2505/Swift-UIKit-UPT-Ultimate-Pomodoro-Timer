import UIKit

class TableLayout: UICollectionViewLayout {

    var itemSize: CGSize = .zero  {
        didSet {
            invalidateLayout()
        }
    }
    
    private let section = 0
    var cache = TableLayoutCache.initial
    
    override var collectionViewContentSize: CGSize {
        return cache.contentSize
    }
    
    override func prepare() {
        super.prepare()
        let numberOfItems = collectionView!.numberOfItems(inSection: section)
        cache = TableLayoutCache(collectionHeight: collectionView!.bounds.height)
        cache.recalculateDefaultFrames(numberOfItems: numberOfItems)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let indexes = cache.visibleRows(in: rect)
        let cells = indexes.map { (row) -> UICollectionViewLayoutAttributes? in
            let path = IndexPath(
                row: row,
                section: section
            )
            let attributes = layoutAttributesForItem(at: path)
            return attributes
        }.compactMap { $0 }
        return cells
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = cache.defaultCellFrame(atElements: indexPath.row)
        return attributes
    }
}
