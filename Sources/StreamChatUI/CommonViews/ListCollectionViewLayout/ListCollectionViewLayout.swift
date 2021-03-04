//
//  Copyright © 2021 Stream.io Inc. All rights reserved.
//

import StreamChat
import UIKit

/// The `ListCollectionViewLayout` delegate to control how to display the list.
public protocol ListCollectionViewLayoutDelegate: class, UICollectionViewDelegate  {
    /// Implement this method to have detailed control over the visibility of the cell separators.
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: ListCollectionViewLayout,
        shouldShowSeparatorForCellAtIndexPath indexPath: IndexPath
    ) -> Bool
}

/// An `UICollectionViewFlowLayout` implementation to make the collection view behave as a `UITableView`.
open class ListCollectionViewLayout: UICollectionViewFlowLayout{

    /// The reuse identifier of the cell separator view.
    open var separatorIdentifier: String = "CellSeparatorIdentifier"

    /// The height of the cell separator view. This changes the `minimumLineSpacing` to properly display the separator height.
    /// By default it is the hair height, one physical pixel (1 / displayScale). If a value is set, it will change the default.
    /// The changes will apply after the layout it has been invalidated.
    open var separatorHeight: CGFloat?

    override open func prepare() {
        super.prepare()

        let defaultSeparatorHeight = 1 / (collectionView?.traitCollection.displayScale ?? 1)
        minimumLineSpacing = separatorHeight ?? defaultSeparatorHeight

        // We should always propose the full width of the collection view for the cell width
        estimatedItemSize = .init(
            width: collectionView?.bounds.width ?? 0,
            height: estimatedItemSize.height
        )
    }
    
    open override func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
        super.invalidateLayout(with: context)
        guard let indexPaths = context.invalidatedItemIndexPaths else {
            return
        }
        context.invalidateDecorationElements(ofKind: separatorIdentifier, at: indexPaths)
        print(context.invalidatedDecorationIndexPaths)
    }

    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        print("LAYOUT!!")
        let cellAttributes = super.layoutAttributesForElements(in: rect) ?? []
        let separatorAttributes = separatorLayoutAttributes(forCellLayoutAttributes: cellAttributes)
        return cellAttributes + separatorAttributes
    }

    open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }
    
    open override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let cellAttributes = super.layoutAttributesForItem(at: indexPath) else { return nil }
        print("DECORATION!!")
        return separatorLayoutAttributes(forCellLayoutAttributes: [cellAttributes]).first
    }

    private func separatorLayoutAttributes(
        forCellLayoutAttributes cellAttributes: [UICollectionViewLayoutAttributes]
    ) -> [UICollectionViewLayoutAttributes] {
        guard let collectionView = collectionView else { return [] }
        let delegate = collectionView.delegate as? ListCollectionViewLayoutDelegate
        return cellAttributes.compactMap { cellAttribute in

            // Check if the delegate explicitly returns `false` otherwise assume the separator should be shown
            guard delegate?.collectionView(
                collectionView,
                layout: self,
                shouldShowSeparatorForCellAtIndexPath: cellAttribute.indexPath
            ) ?? true else { return nil }

            let separatorAttribute = UICollectionViewLayoutAttributes(
                forDecorationViewOfKind: separatorIdentifier,
                with: cellAttribute.indexPath
            )

            let cellFrame = cellAttribute.frame
            print("Separator!!")
            print(cellFrame)
            separatorAttribute.frame = CGRect(
                x: cellFrame.origin.x,
                y: cellFrame.origin.y + cellFrame.size.height,
                width: cellFrame.size.width,
                height: minimumLineSpacing
            )

            return separatorAttribute
        }
    }
}
