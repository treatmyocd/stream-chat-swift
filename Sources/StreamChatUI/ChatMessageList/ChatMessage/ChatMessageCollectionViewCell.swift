//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import StreamChat
import UIKit

public typealias СhatMessageCollectionViewCell = _СhatMessageCollectionViewCell<NoExtraData>

open class _СhatMessageCollectionViewCell<ExtraData: ExtraDataTypes>: _CollectionViewCell, UIConfigProvider {
    // MARK: - Reuse identifiers

    class var reuseId: String { String(describing: self) + String(describing: Self.messageContentViewClass) }
    
    public static var incomingMessage2ReuseId: String { "incoming_2_\(reuseId)" }
    public static var incomingMessage3ReuseId: String { "incoming_3_\(reuseId)" }
    public static var incomingMessage6ReuseId: String { "incoming_6_\(reuseId)" }
    public static var incomingMessage7ReuseId: String { "incoming_7_\(reuseId)" }
    public static var incomingMessage1ReuseId: String { "incoming_1_\(reuseId)" }
    public static var incomingMessage4ReuseId: String { "incoming_4_\(reuseId)" }
    public static var incomingMessage9ReuseId: String { "incoming_9_\(reuseId)" }
    public static var incomingMessage5ReuseId: String { "incoming_5_\(reuseId)" }
    public static var incomingMessage13ReuseId: String { "incoming_13_\(reuseId)" }
    
    public static var outgoingMessage2ReuseId: String { "outgoing_2_\(reuseId)" }
    public static var outgoingMessage3ReuseId: String { "outgoing_3_\(reuseId)" }
    public static var outgoingMessage6ReuseId: String { "outgoing_6_\(reuseId)" }
    public static var outgoingMessage7ReuseId: String { "outgoing_7_\(reuseId)" }
    public static var outgoingMessage1ReuseId: String { "outgoing_1_\(reuseId)" }
    public static var outgoingMessage4ReuseId: String { "outgoing_4_\(reuseId)" }
    public static var outgoingMessage9ReuseId: String { "outgoing_9_\(reuseId)" }
    public static var outgoingMessage5ReuseId: String { "outgoing_5_\(reuseId)" }
    public static var outgoingMessage13ReuseId: String { "outgoing_13_\(reuseId)" }
    
    // MARK: - Properties

    public var message: _ChatMessageGroupPart<ExtraData>? {
        didSet { updateContentIfNeeded() }
    }

    // MARK: - Subviews

    open class var messageContentViewClass: _ChatMessageContentView<ExtraData>.Type { _ChatMessageContentView<ExtraData>.self }

    lazy var container: ContainerView = .init()
    
    public private(set) lazy var messageView: _ChatMessageContentView<ExtraData> = Self.messageContentViewClass.init()
        .withoutAutoresizingMaskConstraints
    
    private var messageViewLeadingConstraint: NSLayoutConstraint?
    private var messageViewTrailingConstraint: NSLayoutConstraint?

    private var hasCompletedStreamSetup = false

    // MARK: - Lifecycle

    let text = UILabel()
    let avatar = ChatAvatarView()
    let bubble = _ChatMessageBubbleView<ExtraData>()
    let metada = _ChatMessageMetadataView<ExtraData>()
    
    let attachmentsView: _ChatMessageAttachmentsView<ExtraData> = .init()
    
    let vStack = ContainerView(axis: .vertical, views: [])
    
    public var quotedMessageView: _ChatMessageQuoteBubbleView<ExtraData>? = .init()
    
    lazy var bubbleContainer = ContainerView(axis: .vertical, views: []).withoutAutoresizingMaskConstraints
    
//    let reactions = _ChatMessageReactionsBubbleView<ExtraData>()
    
    let reaction = UILabel().withoutAutoresizingMaskConstraints
    
    var containerLeadingConstraint: NSLayoutConstraint?
    var containerTrailingConstraint: NSLayoutConstraint?
    
    override open func setUpLayout() {
        contentView.addSubview(container.withoutAutoresizingMaskConstraints)
        contentView.layoutMargins.top = 2
        contentView.layoutMargins.bottom = 2
        
//        contentView.preservesSuperviewLayoutMargins = true
        
        container.alignment = .axisTrailing
        
        containerLeadingConstraint = container.leadingAnchor.pin(equalTo: contentView.layoutMarginsGuide.leadingAnchor)
        containerTrailingConstraint = container.trailingAnchor.pin(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        
        NSLayoutConstraint.activate([
            container.topAnchor.pin(equalTo: contentView.layoutMarginsGuide.topAnchor),
            container.bottomAnchor.pin(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            container.widthAnchor.pin(lessThanOrEqualTo: contentView.layoutMarginsGuide.widthAnchor, multiplier: 0.75),
            
            // Avatar
            avatar.widthAnchor.pin(equalTo: avatar.heightAnchor),
            avatar.widthAnchor.pin(equalToConstant: 30)
        ])
        container.addArrangedSubview(avatar)
        
        vStack.spacing = 1
        vStack.alignment = .axisLeading
        
        vStack.addArrangedSubview(bubble)
        vStack.addArrangedSubview(metada)

        metada.timestampLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        container.addArrangedSubview(vStack)
        
        text.numberOfLines = 0
        text.setContentCompressionResistancePriority(.required, for: .vertical)
        bubbleContainer.addArrangedSubview(text)
        bubbleContainer.isLayoutMarginsRelativeArrangement = true
        
        bubble.addSubview(bubbleContainer)
        bubbleContainer.pin(to: bubble)
        reaction.contentMode = .top
        reaction.setContentCompressionResistancePriority(.required, for: .vertical)
//        container.addArrangedSubview(ContainerView(axis: .vertical, alignment: .fill, views: [reaction, UIView()]))
    }

    override open func updateContent() {
        if message?.isSentByCurrentUser == true {
            container.ordering = .trailingToLeading
            vStack.alignment = .axisTrailing
            containerTrailingConstraint?.isActive = true
            containerLeadingConstraint?.isActive = false

        } else {
            container.ordering = .leadingToTrailing
            vStack.alignment = .axisLeading
            containerTrailingConstraint?.isActive = false
            containerLeadingConstraint?.isActive = true
        }
        
        bubble.message = message
        text.text = message?.text
        
        if message?.text.isEmpty == true {
            bubbleContainer.hideSubview(text, animated: false)
        } else {
            bubbleContainer.showSubview(text, animated: false)
        }
        
        avatar.imageView.loadImage(from: message?.author.imageURL)
        metada.message = message
        
        avatar.isVisible = message?.isLastInGroup == true
        
        if message?.isLastInGroup == false {
            vStack.hideSubview(metada, animated: false)
        } else {
            vStack.showSubview(metada, animated: false)
        }

        if message?.attachments.isEmpty == false {
            attachmentsView.content = .init(
                attachments: message!.attachments.compactMap { $0 as? ChatMessageDefaultAttachment },
                didTapOnAttachment: message!.didTapOnAttachment,
                didTapOnAttachmentAction: message!.didTapOnAttachmentAction
            )
            
            attachmentsView.widthAnchor.pin(equalTo: attachmentsView.heightAnchor, multiplier: 1).isActive = true
//            bubbleContainer.spacing = 0
            bubbleContainer.insertArrangedSubview(attachmentsView, at: 0, respectsLayoutMargins: false)

            attachmentsView.widthAnchor.pin(equalTo: contentView.widthAnchor, multiplier: 1).with(priority: .defaultHigh)
                .isActive = true

            attachmentsView.setContentCompressionResistancePriority(.required, for: .horizontal)
        }
        
        if message?.quotedMessageId != nil {
            bubbleContainer.insertArrangedSubview(quotedMessageView!, at: 0)
            quotedMessageView?.message = message?.quotedMessage
            quotedMessageView?.isParentMessageSentByCurrentUser = message?.isSentByCurrentUser
        }
        
        if message?.reactionScores.isEmpty == false {
//            if reaction.superview == nil {
//                container.addArrangedSubview(reaction)
//            }
            
            reaction.text = message!.reactionScores.keys.first?.rawValue
            
//            if reactions.superview == nil {
//                vStack.insertArrangedSubview(reactions, at: 0)
//            }
//
//            let userReactionIDs = Set(message!.currentUserReactions.map(\.type))
//
//            let isOutgoing = message!.isSentByCurrentUser
//
//            reactions.content = .init(
//                style: isOutgoing ? .smallOutgoing : .smallIncoming,
//                reactions: message!.reactionScores.keys
//                    .sorted { $0.rawValue < $1.rawValue }
//                    .map { .init(type: $0, isChosenByCurrentUser: userReactionIDs.contains($0)) },
//                didTapOnReaction: { _ in }
//            )
        } else {
            if reaction.superview != nil {
//                container.removeArrangedSubview(reaction)
            }
        }
        
//        if message?.reactionScores.isEmpty == false {
//            if reactions.superview == nil {
//                vStack.insertArrangedSubview(reactions, at: 0)
//            } else if reactions.alpha == 0 {
//                vStack.showSubview(reactions, animated: false)
//            }
//
//            let userReactionIDs = Set(message!.currentUserReactions.map(\.type))
//
//            let isOutgoing = message!.isSentByCurrentUser
//
//            reactions.content = .init(
//                style: isOutgoing ? .smallOutgoing : .smallIncoming,
//                reactions: message!.reactionScores.keys
//                    .sorted { $0.rawValue < $1.rawValue }
//                    .map { .init(type: $0, isChosenByCurrentUser: userReactionIDs.contains($0)) },
//                didTapOnReaction: { _ in }
//            )
//        } else {
//            if reactions.superview != nil {
//                vStack.hideSubview(reactions, animated: false)
//            }
//        }
        
//        messageView.message = message
//
//        switch message?.isSentByCurrentUser {
//        case true?:
//            assert(messageViewLeadingConstraint == nil, "The cell was already used for incoming message")
//            if messageViewTrailingConstraint == nil {
//                messageViewTrailingConstraint = messageView.trailingAnchor
//                    .pin(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
//                messageViewTrailingConstraint!.isActive = true
//            }
//
//        case false?:
//            assert(messageViewTrailingConstraint == nil, "The cell was already used for outgoing message")
//            if messageViewLeadingConstraint == nil {
//                messageViewLeadingConstraint = messageView.leadingAnchor
//                    .pin(equalTo: contentView.layoutMarginsGuide.leadingAnchor)
//                messageViewLeadingConstraint!.isActive = true
//            }
//
//        case nil:
//            break
//        }
    }

    // MARK: - Overrides

    override open func prepareForReuse() {
        super.prepareForReuse()

        message = nil
        
//        outlineBorders()
    }

    override open func preferredLayoutAttributesFitting(
        _ layoutAttributes: UICollectionViewLayoutAttributes
    ) -> UICollectionViewLayoutAttributes {
        let preferredAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        
        let targetSize = CGSize(
            width: layoutAttributes.frame.width,
            height: UIView.layoutFittingCompressedSize.height
        )

        preferredAttributes.frame.size = contentView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        
        return preferredAttributes
    }
}
