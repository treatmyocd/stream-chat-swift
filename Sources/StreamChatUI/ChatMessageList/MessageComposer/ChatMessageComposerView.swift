//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import StreamChat
import UIKit

public typealias ChatMessageComposerView = _ChatMessageComposerView<NoExtraData>

open class _ChatMessageComposerView<ExtraData: ExtraDataTypes>: _View,
    UIConfigProvider {
    public var attachmentsViewHeight: CGFloat = .zero
    public var stateIconHeight: CGFloat = .zero

    public struct Content {
        public var text: String
        public var threadParentMessage: _ChatMessage<ExtraData>?
        public var editingMessage: _ChatMessage<ExtraData>?
        public var quotingMessage: _ChatMessage<ExtraData>?
        public var command: Command?
    }

    /// The content of this view.
    public var content: Content? {
        didSet {
            updateContentIfNeeded()
        }
    }

    public enum State {
        case initial
        case slashCommand(Command)
        case quote(_ChatMessage<ExtraData>)
        case edit(_ChatMessage<ExtraData>)
    }

    public var state: State = .initial {
        didSet {
            updateContent()
        }
    }

    public private(set) lazy var container = UIStackView()
        .withoutAutoresizingMaskConstraints

    public private(set) lazy var topContainer = UIStackView()
        .withoutAutoresizingMaskConstraints

    public private(set) lazy var bottomContainer = UIStackView()
        .withoutAutoresizingMaskConstraints

    public private(set) lazy var centerWrapperContainer = UIStackView()
        .withoutAutoresizingMaskConstraints

    public private(set) lazy var centerContainer = ContainerStackView()
        .withoutAutoresizingMaskConstraints

    public private(set) lazy var leftContainer = UIStackView()
        .withoutAutoresizingMaskConstraints

    public private(set) lazy var rightContainer = UIStackView()
        .withoutAutoresizingMaskConstraints
    
    public private(set) lazy var messageQuoteView = uiConfig
        .messageQuoteView.init()
        .withoutAutoresizingMaskConstraints
    
    public private(set) lazy var imageAttachmentsView = uiConfig
        .messageComposer
        .imageAttachmentsView.init()
        .withoutAutoresizingMaskConstraints
    
    public private(set) lazy var documentAttachmentsView = uiConfig
        .messageComposer
        .documentAttachmentsView.init()
        .withoutAutoresizingMaskConstraints
    
    public private(set) lazy var messageInputView = uiConfig
        .messageComposer
        .messageInputView.init()
        .withoutAutoresizingMaskConstraints

    /// Convenience getter for underlying `textView`.
    public var textView: _ChatMessageComposerInputTextView<ExtraData> {
        messageInputView.textView
    }
    
    public private(set) lazy var sendButton = uiConfig
        .messageComposer
        .sendButton.init()
        .withoutAutoresizingMaskConstraints
    
    public private(set) lazy var attachmentButton: UIButton = uiConfig
        .messageComposer
        .composerButton.init()
        .withoutAutoresizingMaskConstraints
    
    public private(set) lazy var commandsButton: UIButton = uiConfig
        .messageComposer
        .composerButton.init()
        .withoutAutoresizingMaskConstraints
    
    public private(set) lazy var shrinkInputButton: UIButton = uiConfig
        .messageComposer
        .composerButton.init()
        .withoutAutoresizingMaskConstraints
    
    public private(set) lazy var stateIcon: UIImageView = {
        let imageView = UIImageView().withoutAutoresizingMaskConstraints
        imageView.contentMode = .center
        imageView.widthAnchor.pin(equalTo: imageView.heightAnchor, multiplier: 1).isActive = true
        return imageView
    }()
    
    public private(set) lazy var dismissButton: UIButton = uiConfig
        .messageComposer
        .composerButton.init()
        .withoutAutoresizingMaskConstraints
    
    public private(set) lazy var titleLabel: UILabel = UILabel()
        .withoutAutoresizingMaskConstraints
        .withBidirectionalLanguagesSupport
    
    public private(set) lazy var checkmarkControl: _ChatMessageComposerCheckmarkControl<ExtraData> = uiConfig
        .messageComposer
        .checkmarkControl.init()
        .withoutAutoresizingMaskConstraints
    
    // MARK: - Overrides
    
    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard superview != nil else { return }
        
        setUp()
        setUpLayout()
        (self as! Self).applyDefaultAppearance()
        setUpAppearance()
        updateContent()
    }
    
    // MARK: - Public
    
    override public func defaultAppearance() {
        super.defaultAppearance()
        stateIconHeight = 40
        
        backgroundColor = uiConfig.colorPalette.popoverBackground
        
        centerContainer.clipsToBounds = true
        centerContainer.layer.cornerRadius = 25
        centerContainer.layer.borderWidth = 1
        centerContainer.layer.borderColor = uiConfig.colorPalette.border.cgColor
        
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = 0.5
        
        let clipIcon = uiConfig.images.messageComposerFileAttachment.tinted(with: uiConfig.colorPalette.inactiveTint)
        attachmentButton.setImage(clipIcon, for: .normal)
        
        let boltIcon = uiConfig.images.messageComposerCommand.tinted(with: uiConfig.colorPalette.inactiveTint)
        commandsButton.setImage(boltIcon, for: .normal)
        
        let shrinkArrowIcon = uiConfig.images.messageComposerShrinkInput
        shrinkInputButton.setImage(shrinkArrowIcon, for: .normal)
        
        let dismissIcon = uiConfig.images.close1.tinted(with: uiConfig.colorPalette.inactiveTint)
        dismissButton.setImage(dismissIcon, for: .normal)
        
        titleLabel.textAlignment = .center
        titleLabel.textColor = uiConfig.colorPalette.text
        titleLabel.font = uiConfig.font.bodyBold
        titleLabel.adjustsFontForContentSizeCategory = true
    }
    
    override open func setUpLayout() {
        super.setUpLayout()
        embed(container)

        container.preservesSuperviewLayoutMargins = true
        container.isLayoutMarginsRelativeArrangement = true
        container.spacing = UIStackView.spacingUseSystem
        container.axis = .vertical
        container.alignment = .fill
        container.addArrangedSubview(topContainer)
        container.addArrangedSubview(centerWrapperContainer)
        container.addArrangedSubview(bottomContainer)

        topContainer.alignment = .fill
        topContainer.addArrangedSubview(stateIcon)
        topContainer.addArrangedSubview(titleLabel)
        topContainer.addArrangedSubview(dismissButton)
        stateIcon.heightAnchor.pin(equalToConstant: stateIconHeight).isActive = true

        centerWrapperContainer.axis = .horizontal
        centerWrapperContainer.alignment = .fill
        centerWrapperContainer.addArrangedSubview(leftContainer)
        centerWrapperContainer.addArrangedSubview(centerContainer)
        centerWrapperContainer.addArrangedSubview(rightContainer)

        centerContainer.axis = .vertical
        centerContainer.alignment = .fill
        centerContainer.addArrangedSubview(messageQuoteView)
        centerContainer.addArrangedSubview(imageAttachmentsView)
        centerContainer.addArrangedSubview(documentAttachmentsView)
        centerContainer.addArrangedSubview(messageInputView)
        centerContainer.hideSubview(messageQuoteView, animated: false)
        centerContainer.hideSubview(imageAttachmentsView, animated: false)
        centerContainer.hideSubview(documentAttachmentsView, animated: false)
        imageAttachmentsView.heightAnchor.pin(equalToConstant: 120).isActive = true

        rightContainer.alignment = .center
        rightContainer.spacing = .auto
        rightContainer.addArrangedSubview(sendButton)

        leftContainer.axis = .horizontal
        leftContainer.alignment = .center
        leftContainer.addArrangedSubview(shrinkInputButton)
        leftContainer.addArrangedSubview(attachmentButton)
        leftContainer.addArrangedSubview(commandsButton)

        bottomContainer.addArrangedSubview(checkmarkControl)
        bottomContainer.isHidden = true
        
        [shrinkInputButton, attachmentButton, commandsButton, sendButton, dismissButton]
            .forEach { button in
                button.pin(anchors: [.width], to: button.intrinsicContentSize.width)
                button.pin(anchors: [.height], to: button.intrinsicContentSize.height)
            }
    }
    
    open func setCheckmarkView(hidden: Bool) {
        if bottomContainer.isHidden != hidden {
            bottomContainer.isHidden = hidden
        }
    }
}
