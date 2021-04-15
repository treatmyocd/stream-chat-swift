//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import StreamChat
import UIKit

typealias ImageGalleryVC = _ImageGalleryVC<NoExtraData>

open class _ImageGalleryVC<ExtraData: ExtraDataTypes>: _ViewController, UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {
    open var content: _ChatMessage<ExtraData>! {
        didSet {
            updateContentIfNeeded()
        }
    }
    
    open var images: [ChatMessageDefaultAttachment] = []
    
    public private(set) lazy var attachmentsFlowLayout = UICollectionViewFlowLayout()
    
    public private(set) lazy var attachmentsCollectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: attachmentsFlowLayout
    )
    .withoutAutoresizingMaskConstraints
    
    override open func setUp() {
        super.setUp()
        attachmentsFlowLayout.scrollDirection = .horizontal
        attachmentsFlowLayout.minimumInteritemSpacing = 0
        attachmentsFlowLayout.minimumLineSpacing = 0
        
        attachmentsCollectionView.isPagingEnabled = true
        attachmentsCollectionView.alwaysBounceVertical = false
        attachmentsCollectionView.alwaysBounceHorizontal = true
        attachmentsCollectionView.dataSource = self
        attachmentsCollectionView.delegate = self
        attachmentsCollectionView.register(
            ImageCollectionViewCell.self,
            forCellWithReuseIdentifier: ImageCollectionViewCell.reuseId
        )
    }
    
    override open func setUpLayout() {
        super.setUpLayout()
        
        view.embed(attachmentsCollectionView)
    }
    
    override open func updateContent() {
        super.updateContent()
        
        images = content.attachments
            .filter { $0.type == .image }
            .compactMap { $0 as? ChatMessageDefaultAttachment }
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let image = images[indexPath.item]
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ImageCollectionViewCell.reuseId,
            for: indexPath
        ) as! ImageCollectionViewCell
        cell.content = image
        return cell
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        collectionView.bounds.size
    }
    
    override open func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        attachmentsFlowLayout.invalidateLayout()
    }
}

open class ImageCollectionViewCell: _CollectionViewCell {
    open class var reuseId: String { String(describing: self) }
    
    open var content: ChatMessageDefaultAttachment! {
        didSet { updateContentIfNeeded() }
    }
    
    public private(set) lazy var imageView: UIImageView = UIImageView()
        .withoutAutoresizingMaskConstraints
    
    override public func defaultAppearance() {
        super.defaultAppearance()
        
        imageView.contentMode = .scaleAspectFit
    }
    
    override open func setUpLayout() {
        super.setUpLayout()
        
        contentView.embed(imageView)
    }
    
    override open func updateContent() {
        super.updateContent()
        
        // TODO: Load preview URL if available first
        imageView.loadImage(from: content.imageURL)
    }
}
